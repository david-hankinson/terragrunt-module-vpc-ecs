package test

import (
	"fmt"
	"testing"

	"github.com/gruntwork-io/terratest/modules/aws"
	"github.com/gruntwork-io/terratest/modules/terraform"

	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
)

func TestVpcAndSubnets(t *testing.T) {
	t.Parallel()

	awsRegion := "ca-central-1"

	opts := &terraform.Options{
		TerraformDir:    "../infrastructure-live/non-prod/vpc",
		TerraformBinary: "tofu",

		// Variables to pass to our Terraform code using -var options
		Vars: map[string]interface{}{
			"region": awsRegion,
		},
	}

	defer terraform.Destroy(t, opts)
	terraform.InitAndApply(t, opts)

	vpcID := terraform.Output(t, opts, "vpc_id")
	pubIDs := terraform.OutputList(t, opts, "public_subnet_ids")
	privIDs := terraform.OutputList(t, opts, "private_subnet_ids")
	fmt.Printf("Provisioned VPC Name: %s\n", vpcID)

	// type Vpc struct {
	// 	Id                   string            // The ID of the VPC
	// 	Name                 string Test Variables: These are defined in your terraform.Options struct within the Vars or VarFiles attributes.           // The name of the VPC
	// 	Subnets              []Subnet          // A list of subnets in the VPC
	// 	Tags                 map[string]string // The tags associated with the VPC
	// 	CidrBlock            *string           // The primary IPv4 CIDR block for the VPC.
	// 	CidrAssociations     []*string         // Information about the IPv4 CIDR blocks associated with the VPC.
	// 	Ipv6CidrAssociations []*string         // Information about the IPv6 CIDR blocks associated with the VPC.
	// }

	vpc_struct := aws.GetVpcById(t, vpcID, awsRegion)

	assert.Equal(t, vpcID, vpc_struct.Id)

	assert.Equal(t, "10.1.0.0/16", *vpc_struct.CidrBlock)

	// “public + private subnets exist” tests in the outputs
	require.Len(t, pubIDs, 2)
	require.Len(t, privIDs, 2)

	// use the terratest aws module to confirm 4 subnets are present in the aws account
	require.Len(t, vpc_struct.Subnets, 4)
}
