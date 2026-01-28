package test

import (
	"path/filepath"
	"testing"

	"github.com/gruntwork-io/terratest/modules/files"
	"github.com/gruntwork-io/terratest/modules/terragrunt"
	"github.com/stretchr/testify/require"
)

func TestTerragruntUnits(t *testing.T) {
	t.Parallel()

	testFolder, err := files.CopyTerragruntFolderToTemp("../../terragrunt-module-vpc-ecs/", t.Name())
	require.NoError(t, err)

	options := &terragrunt.Options{
		TerragruntDir: filepath.Join(testFolder, "infrastructure-live", "non-prod", "vpc"),
		// TerragruntDir: testFolder,
	}

	// defer terragrunt.DestroyAll(t, options)
	terragrunt.Init(t, options)

	// exitCode := terragrunt.Plan(t, options)
	// require.Equal(t, 0, exitCode)
}
