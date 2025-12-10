local orgs = import 'vendor/otterdog-defaults/otterdog-defaults.libsonnet';

local newBranchProtectionRule(branchName) = orgs.newBranchProtectionRule(branchName) {
  required_approving_review_count: null,
  requires_pull_request: false,
  requires_status_checks: false,
};

orgs.newOrg('technology.cbi', 'eclipse-cbi') {
  settings+: {
    blog: "https://projects.eclipse.org/projects/technology.cbi",
    description: "The Eclipse CBI project",
    email: "cbi-dev@eclipse.org",
    location: "Belgium",
    name: "Eclipse CBI",
    packages_containers_internal: false,
    workflows+: {
      allow_action_patterns+: [
        "eclipse-dash/dash-licenses/.github/actions/maven-license-check-action@*",
        "geekyeggo/delete-artifact@*",
        "jreleaser/release-action/.github/*@*",
        "ludeeus/action-shellcheck@*",
        "marocchino/sticky-pull-request-comment@*",
        "release-drafter/release-drafter@*",
        "rossjrw/pr-preview-action@*",
        "JamesIves/github-pages-deploy-action@*",
        "slsa-framework/slsa-github-generator/*",
        "softprops/action-gh-release@*",
        "stCarolas/setup-maven@*",
        "sonatype-nexus-community/iq-github-action@*",
        "appleboy/scp-action@*",
      ],
      allowed_actions: "selected",
      default_workflow_permissions: "write",
    },
  },
  webhooks+: [
    orgs.newOrgWebhook('https://ci.eclipse.org/cbi/github-webhook/') {
      events+: [
        "create",
        "delete",
        "organization",
        "pull_request",
        "pull_request_review_comment",
        "push",
        "repository"
      ],
      secret: "pass:bots/technology.cbi/github.com/webhook-secret",
    },
  ],
  secrets+: [
    orgs.newOrgSecret('ECLIPSE_GITLAB_API_TOKEN') {
      selected_repositories+: [
        "org.eclipse.cbi",
        "eclipse-cbi-tycho-example"
      ],
      value: "pass:bots/technology.cbi/gitlab.eclipse.org/api-token",
      visibility: "selected",
    },
    orgs.newOrgSecret('DEVELOCITY_ACCESS_KEY') {
      value: "pass:bots/technology.cbi/develocity.eclipse.org/gh-api-token",
    },
    orgs.newOrgSecret('GH_PREVIEW_TOKEN') {
      value: "pass:bots/technology.cbi/github.com/preview-token",
    },    
    orgs.newOrgSecret('GPG_KEY_ID') {
      value: "pass:bots/technology.cbi/gpg/key_id",
    },
    orgs.newOrgSecret('GPG_PASSPHRASE') {
      value: "pass:bots/technology.cbi/gpg/passphrase",
    },
    orgs.newOrgSecret('GPG_PRIVATE_KEY') {
      value: "pass:bots/technology.cbi/gpg/secret-subkeys.asc",
    },
    orgs.newOrgSecret('GPG_SUBKEY_ID') {
      value: "pass:bots/technology.cbi/gpg/subkey_id",
    },
    orgs.newOrgSecret('CENTRAL_SONATYPE_TOKEN_PASSWORD') {
      value: "pass:bots/technology.cbi/central.sonatype.org/token-password",
    },
    orgs.newOrgSecret('CENTRAL_SONATYPE_TOKEN_USERNAME') {
      value: "pass:bots/technology.cbi/central.sonatype.org/token-username",
    },
    orgs.newOrgSecret('REPO3_TOKEN_PASSWORD') {
      value: "pass:bots/technology.cbi/repo3.eclipse.org/token-password",
    },
    orgs.newOrgSecret('REPO3_TOKEN_USERNAME') {
      value: "pass:bots/technology.cbi/repo3.eclipse.org/token-username",
    },
  ],
  _repositories+:: [
    orgs.newRepo('.github') {
      local thisRepo = self,
      allow_merge_commit: true,
      allow_update_branch: false,
      default_branch: "master",
      dependabot_security_updates_enabled: true,
      description: "Global configurations for the eclipse-cbi GitHub organization",
      workflows+: {
        default_workflow_permissions: "write",
      },
      branch_protection_rules: [
        newBranchProtectionRule(thisRepo.default_branch),
      ],
    },
    orgs.newRepo('ansible-playbooks') {
      local thisRepo = self,
      allow_merge_commit: true,
      allow_update_branch: false,
      dependabot_security_updates_enabled: true,
      description: "Ansible playbooks for CBI",
      workflows+: {
        default_workflow_permissions: "write",
      },
      branch_protection_rules: [
        newBranchProtectionRule(thisRepo.default_branch),
      ],
    },
    orgs.newRepo('best-practices') {
      local thisRepo = self,
      allow_merge_commit: true,
      allow_update_branch: false,
      dependabot_security_updates_enabled: true,
      description: "Collection of best practices for Common Build Infrastructure",
      workflows+: {
        default_workflow_permissions: "write",
      },
      branch_protection_rules: [
        newBranchProtectionRule(thisRepo.default_branch),
      ],
    },
    orgs.newRepo('buildkitd-okd') {
      local thisRepo = self,
      allow_merge_commit: true,
      allow_update_branch: false,
      dependabot_security_updates_enabled: true,
      workflows+: {
        default_workflow_permissions: "write",
      },
      branch_protection_rules: [
        newBranchProtectionRule(thisRepo.default_branch),
      ],
    },
    orgs.newRepo('cbi') {
      allow_merge_commit: true,
      allow_update_branch: false,
      dependabot_security_updates_enabled: true,
      workflows+: {
        default_workflow_permissions: "write",
      },
    },
    orgs.newRepo('cbi-actions') {
      description: "Eclipse CBI Github Actions library for Eclipse Foundation services",
      gh_pages_build_type: "legacy",
      gh_pages_source_branch: "gh-pages",
      gh_pages_source_path: "/",
      environments: [
        orgs.newEnvironment('github-pages'),
      ],
    },
    orgs.newRepo('cbi-website') {
      local thisRepo = self,
      description: "Eclipse CBI Website Project based on mkdocs",
      gh_pages_build_type: "legacy",
      gh_pages_source_branch: "gh-pages",
      gh_pages_source_path: "/",
      allow_merge_commit: true,
      allow_update_branch: false,
      dependabot_security_updates_enabled: true,
      workflows+: {
        default_workflow_permissions: "write",
      },
      branch_protection_rules: [
        newBranchProtectionRule(thisRepo.default_branch),
      ],
      environments: [
        orgs.newEnvironment('github-pages'),
        orgs.newEnvironment('pull-request-preview'),
      ],
      has_discussions: true,
    },
    orgs.newRepo('cbi-website-preview') {
      description: "PR Preview Project for Eclipse CBI Website",
      gh_pages_build_type: "legacy",
      gh_pages_source_branch: "gh-pages-preview",
      gh_pages_source_path: "/",
      environments: [
        orgs.newEnvironment('github-pages'),
      ],
    },
    orgs.newRepo('central-staging-plugins') {
      description: "Plugins for managing staging artifacts from the Sonatype Central Portal",
      dependabot_security_updates_enabled: true,
      workflows+: {
        default_workflow_permissions: "write",
      },
    },
    orgs.newRepo('central-staging-plugins-assembly-template') {
      description: "Assembly template for the Central Staging Plugins to be used to generate a bundle for the Sonatype Central Portal",
      dependabot_security_updates_enabled: true,
      workflows+: {
        default_workflow_permissions: "write",
      },
    },
    orgs.newRepo('ci-admin') {
      local thisRepo = self,
      allow_squash_merge: false,
      allow_update_branch: false,
      default_branch: "master",
      dependabot_security_updates_enabled: true,
      workflows+: {
        default_workflow_permissions: "write",
      },
      branch_protection_rules: [
        newBranchProtectionRule(thisRepo.default_branch),
      ],
    },
    orgs.newRepo('dockerfiles') {
      local thisRepo = self,
      allow_merge_commit: true,
      allow_update_branch: false,
      default_branch: "master",
      dependabot_security_updates_enabled: true,
      description: "Various Dockerfiles for building stuff @ Eclipse",
      workflows+: {
        default_workflow_permissions: "write",
      },
      webhooks: [
        orgs.newRepoWebhook('https://ci.eclipse.org/cbi/github-webhook/') {
          content_type: "json",
          events+: [
            "create",
            "delete",
            "push"
          ],
          secret: "********",
        },
      ],
      branch_protection_rules: [
        newBranchProtectionRule(thisRepo.default_branch),
      ],
    },
    orgs.newRepo('dockertools') {
      local thisRepo = self,
      allow_merge_commit: true,
      allow_update_branch: false,
      default_branch: "master",
      dependabot_security_updates_enabled: true,
      workflows+: {
        default_workflow_permissions: "write",
      },
      branch_protection_rules: [
        newBranchProtectionRule(thisRepo.default_branch),
      ],
    },
    orgs.newRepo('eclipse-cbi-tycho-example') {
      local thisRepo = self,
      allow_merge_commit: true,
      allow_update_branch: false,
      dependabot_security_updates_enabled: true,
      description: "Eclipse CBI Tycho example project",
      homepage: "",
      topics+: [
        "cbi",
        "eclipse",
        "example",
        "maven",
        "tycho"
      ],
      workflows+: {
        default_workflow_permissions: "write",
      },
      secrets+: [
        orgs.newRepoSecret('SCP_KEY') {
          value: "pass:bots/technology.cbi/projects-storage.eclipse.org/id_ed25519",
        },
        orgs.newRepoSecret('SCP_PASSPHRASE') {
          value: "pass:bots/technology.cbi/projects-storage.eclipse.org/id_ed25519.passphrase",
        },
        orgs.newRepoSecret('SCP_USERNAME') {
          value: "pass:bots/technology.cbi/projects-storage.eclipse.org/username",
        },
      ],
      branch_protection_rules: [
        newBranchProtectionRule(thisRepo.default_branch),
      ],
    },
    orgs.newRepo('epl-license-feature') {
      local thisRepo = self,
      allow_merge_commit: true,
      allow_update_branch: false,
      dependabot_security_updates_enabled: true,
      workflows+: {
        default_workflow_permissions: "write",
      },
      branch_protection_rules: [
        newBranchProtectionRule(thisRepo.default_branch),
      ],
    },
    orgs.newRepo('hipp2jipp') {
      archived: true,
      default_branch: "master",
      description: "A tool that converts Hudson config files to make them compatible with Jenkins",
      homepage: "",
      topics+: [
        "cbi",
        "config",
        "conversion",
        "hudson",
        "jenkins",
        "migration"
      ],
      workflows+: {
        default_workflow_permissions: "write",
      },
      webhooks: [
        orgs.newRepoWebhook('https://ci.eclipse.org/cbi/github-webhook/') {
          events+: [
            "pull_request",
            "push"
          ],
        },
      ],
    },
    orgs.newRepo('jiro') {
      local thisRepo = self,
      allow_squash_merge: false,
      allow_update_branch: false,
      default_branch: "master",
      dependabot_security_updates_enabled: true,
      description: "Jenkins infrastructure for projects hosted by the Eclipse Foundation",
      workflows+: {
        default_workflow_permissions: "write",
      },
      branch_protection_rules: [
        newBranchProtectionRule(thisRepo.default_branch),
      ],
    },
    orgs.newRepo('jiro-agents') {
      local thisRepo = self,
      allow_squash_merge: false,
      allow_update_branch: false,
      default_branch: "master",
      dependabot_security_updates_enabled: true,
      description: "Jenkins agent images for projects hosted by the Eclipse Foundation",
      homepage: "",
      topics: [
        "docker",
        "docker-image",
        "eclipse",
        "jenkins",
      ],
      workflows+: {
        default_workflow_permissions: "write",
      },
      branch_protection_rules: [
        newBranchProtectionRule(thisRepo.default_branch),
      ],
    },
    orgs.newRepo('jiro-dashboard') {
      local thisRepo = self,
      allow_merge_commit: true,
      allow_update_branch: false,
      default_branch: "master",
      delete_branch_on_merge: false,
      dependabot_security_updates_enabled: true,
      workflows+: {
        default_workflow_permissions: "write",
      },
      branch_protection_rules: [
        newBranchProtectionRule(thisRepo.default_branch),
      ],
    },
    orgs.newRepo('jiro-masters') {
      local thisRepo = self,
      allow_squash_merge: false,
      allow_update_branch: false,
      default_branch: "master",
      dependabot_security_updates_enabled: true,
      description: "Jenkins master (base) images for projects hosted by the Eclipse Foundation",
      homepage: "",
      workflows+: {
        default_workflow_permissions: "write",
      },
      branch_protection_rules: [
        newBranchProtectionRule(thisRepo.default_branch),
      ],
    },
    orgs.newRepo('jiro-static-agents') {
      local thisRepo = self,
      allow_merge_commit: true,
      allow_update_branch: false,
      delete_branch_on_merge: false,
      dependabot_security_updates_enabled: true,
      workflows+: {
        default_workflow_permissions: "write",
      },
      branch_protection_rules: [
        newBranchProtectionRule(thisRepo.default_branch),
      ],
    },
    orgs.newRepo('macos-notarization-service') {
      local thisRepo = self,
      dependabot_security_updates_enabled: true,
      description: "REST Service to notarize macOS application bundles and DMG",
      has_discussions: true,
      homepage: "",
      workflows+: {
        default_workflow_permissions: "write",
      },
      secrets+: [
        orgs.newRepoSecret('IQ_TOKEN') {
          value: "pass:bots/technology.cbi/sonatype-lifecycle/iq-token",
        },
      ],
      webhooks: [
        orgs.newRepoWebhook('https://ci.eclipse.org/cbi/github-webhook/') {
          content_type: "json",
          events+: [
            "create",
            "delete",
            "pull_request",
            "pull_request_review_comment",
            "push"
          ],
          secret: "********",
        },
      ],
      branch_protection_rules: [
        newBranchProtectionRule(thisRepo.default_branch),
      ],
    },
    orgs.newRepo('nexus3-as-code') {
      local thisRepo = self,
      dependabot_security_updates_enabled: true,
      description: "Manage Nexus3 configuration as code with Terraform",
      workflows+: {
        default_workflow_permissions: "write",
      },
      branch_protection_rules: [
        newBranchProtectionRule(thisRepo.default_branch),
      ],
    },
    orgs.newRepo('org.eclipse.cbi') {
      local thisRepo = self,
      dependabot_security_updates_enabled: true,
      description: "CBI Maven plugins and Webservices",
      gh_pages_build_type: "workflow",
      homepage: "https://eclipse-cbi.github.io/org.eclipse.cbi/",
      workflows+: {
        default_workflow_permissions: "write",
      },
      branch_protection_rules: [
        newBranchProtectionRule(thisRepo.default_branch),
      ],
    },
    orgs.newRepo('org.eclipse.cbi-testdata') {
      local thisRepo = self,
      allow_merge_commit: true,
      allow_update_branch: false,
      delete_branch_on_merge: false,
      dependabot_security_updates_enabled: true,
      workflows+: {
        default_workflow_permissions: "write",
      },
      branch_protection_rules: [
        newBranchProtectionRule(thisRepo.default_branch),
      ],
    },
    orgs.newRepo('p2repo-aggregator') {
      local thisRepo = self,
      allow_merge_commit: false,
      allow_update_branch: false,
      delete_branch_on_merge: false,
      dependabot_security_updates_enabled: true,
      workflows+: {
        default_workflow_permissions: "write",
      },
      branch_protection_rules: [
        newBranchProtectionRule(thisRepo.default_branch),
      ],
    },
    orgs.newRepo('p2repo-analyzers') {
      local thisRepo = self,
      allow_merge_commit: false,
      allow_update_branch: false,
      delete_branch_on_merge: false,
      dependabot_security_updates_enabled: true,
      workflows+: {
        default_workflow_permissions: "write",
      },
      branch_protection_rules: [
        newBranchProtectionRule(thisRepo.default_branch),
      ],
    },
    orgs.newRepo('p2repo-sbom') {
      local thisRepo = self,
      allow_merge_commit: false,
      allow_update_branch: false,
      delete_branch_on_merge: false,
      dependabot_security_updates_enabled: true,
      workflows+: {
        default_workflow_permissions: "write",
      },
      branch_protection_rules: [
        newBranchProtectionRule(thisRepo.default_branch),
      ],
      has_discussions: true,
    },
    orgs.newRepo('sonatype-nexus') {
      local thisRepo = self,
      allow_merge_commit: true,
      allow_update_branch: false,
      default_branch: "master",
      delete_branch_on_merge: false,
      dependabot_security_updates_enabled: true,
      description: "Docker images and Kubernetes deployment files for Sonatype Nexus repositories hosted by the Eclipse Foundation",
      workflows+: {
        default_workflow_permissions: "write",
      },
      branch_protection_rules: [
        newBranchProtectionRule(thisRepo.default_branch),
      ],
    },
    orgs.newRepo('targetplatform-dsl') {
      local thisRepo = self,
      allow_squash_merge: false,
      allow_update_branch: false,
      default_branch: "master",
      dependabot_security_updates_enabled: true,
      description: "Target Platform Definition DSL and Generator",
      homepage: "",
      workflows+: {
        default_workflow_permissions: "write",
      },
      webhooks: [
        orgs.newRepoWebhook('https://notify.travis-ci.org') {
          events+: [
            "create",
            "delete",
            "issue_comment",
            "member",
            "public",
            "pull_request",
            "push",
            "repository"
          ],
        },
      ],
      branch_protection_rules: [
        newBranchProtectionRule(thisRepo.default_branch),
      ],
      environments: [
        orgs.newEnvironment('github-pages'),
      ],
    },
    orgs.newRepo('misc-checks') {
      local thisRepo = self,
      allow_merge_commit: true,
      allow_update_branch: false,
      dependabot_security_updates_enabled: true,
      description: "Miscellaneous workflow checks for CBI",
      workflows+: {
        default_workflow_permissions: "write",
      },
      branch_protection_rules: [
        newBranchProtectionRule(thisRepo.default_branch),
      ],
    },
    orgs.newRepo('helm-charts') {
      description: "This repository contains the helm-charts source from Eclipse Foundation Common Build Infrastructure projects.",
      gh_pages_build_type: "legacy",
      gh_pages_source_branch: "gh-pages",
      gh_pages_source_path: "/",      
      homepage: "https://eclipse-cbi.github.io/helm-charts/",
      environments: [
        orgs.newEnvironment('github-pages') {
          branch_policies+: [
            "gh-pages"
          ],
          deployment_branch_policy: "selected",
        },
      ],
    }
  ],
}
