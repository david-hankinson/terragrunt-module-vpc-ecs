package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestPlanSucceeds(t *testing.T) {
	t.Parallel()

	opts := &terraform.Options{
		TerraformDir:    "../module",
		TerraformBinary: "tofu", // 👈 OpenTofu CLI
	}

	terraform.Init(t, opts)
	terraform.Plan(t, opts) // ✅ test fails if plan errors
}
