package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/require"
)

func TestNetworkBasics(t *testing.T) {
	t.Parallel()

	opts := &terraform.Options{
		TerraformDir:    "../module",
		TerraformBinary: "tofu", // 👈 OpenTofu
	}

	defer terraform.Destroy(t, opts)
	terraform.InitAndApply(t, opts)

	// 1) VPC CIDR is correct
	vpcCidr := terraform.Output(t, opts, "vpc_cidr")
	require.Equal(t, "10.1.0.0/16", vpcCidr)

	// 2) Created 2 public subnets
	publicSubnetIDs := terraform.OutputList(t, opts, "public_subnet_ids")
	require.Len(t, publicSubnetIDs, 2)

	// 3) Private subnets have correct CIDRs
	privateCidrs := terraform.OutputList(t, opts, "private_subnet_cidrs")
	require.ElementsMatch(t, []string{"10.1.3.0/24", "10.1.4.0/24"}, privateCidrs)
}
