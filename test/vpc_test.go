package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestPlanSucceeds(t *testing.T) {
	t.Parallel()

	opts := &terraform.Options{
		TerraformDir:    "../module",
		TerraformBinary: "tofu",
	}

	terraform.Init(t, opts)
	terraform.Plan(t, opts)
}
