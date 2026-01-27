package test

import (
	"fmt"
	"testing"
	"time"

	"github.com/gruntwork-io/terratest/modules/aws"
	"github.com/gruntwork-io/terratest/modules/retry"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
)

func TestVpcAndSubnets(t *testing.T) {
	t.Parallel()

	opts := &terraform.Options{
		TerraformDir:    "../infrastructure-live/non-prod/vpc",
		TerraformBinary: "tofu",
	}

	defer terraform.Destroy(t, opts)
	terraform.InitAndApply(t, opts)

	vpcID := terraform.Output(t, opts, "vpc_id")
	pubIDs := terraform.OutputList(t, opts, "public_subnets_ids")
	privIDs := terraform.OutputList(t, opts, "private_subnets_ids")
	fmt.Printf("Provisioned VPC Name: %s\n", vpcID)
	fmt.Printf("Provisioned pubIDs: %s\n", pubIDs)
	fmt.Printf("Provisioned privIDs: %s\n", privIDs)

	// type Vpc struct {
	// 	Id                   string            // The ID of the VPC
	// 	Name                 string Test Variables: These are defined in your terraform.Options struct within the Vars or VarFiles attributes.           // The name of the VPC
	// 	Subnets              []Subnet          // A list of subnets in the VPC
	// 	Tags                 map[string]string // The tags associated with the VPC
	// 	CidrBlock            *string           // The primary IPv4 CIDR block for the VPC.
	// 	CidrAssociations     []*string         // Information about the IPv4 CIDR blocks associated with the VPC.
	// 	Ipv6CidrAssociations []*string         // Information about the IPv6 CIDR blocks associated with the VPC.
	// }

	var vpc *aws.Vpc

	retry.DoWithRetry(t, "Wait for VPC to be discoverable", 100, 15*time.Second, func() (string, error) {
		var err error
		vpc, err = aws.GetVpcByIdE(t, vpcID, "ca-central-1")
		if err != nil {
			return "", err
		}
		return "VPC found", nil
	})

	assert.Equal(t, vpcID, vpc.Id)
	assert.Equal(t, "10.50.0.0/16", *vpc.CidrBlock)
	require.Len(t, vpc.Subnets, 4)

	// // “public + private subnets exist” tests in the outputs
	require.Len(t, pubIDs, 2)
	require.Len(t, privIDs, 2)

	// use the terratest aws module to confirm 4 subnets are present in the aws account
	require.Len(t, vpc.Subnets, 4)
}
