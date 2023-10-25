local orgs = import 'vendor/otterdog-defaults/otterdog-defaults.libsonnet';

local newBranchProtectionRule(branchName) = orgs.newBranchProtectionRule(branchName) {
  required_approving_review_count: null,
  requires_pull_request: false,
  requires_status_checks: false,
};

orgs.newOrg('eclipse-cbi') {
  settings+: {
    blog: "https://projects.eclipse.org/projects/technology.cbi",
    description: "The Eclipse CBI project",
    email: "cbi-dev@eclipse.org",
    location: "Belgium",
    name: "Eclipse CBI",
    packages_containers_internal: false,
    readers_can_create_discussions: true,
    security_managers+: [
      "technology-cbi-project-leads"
    ],
    workflows+: {
      allow_action_patterns+: [
        "ludeeus/action-shellcheck@*",
        "marocchino/sticky-pull-request-comment@*",
        "release-drafter/release-drafter@*",
        "slsa-framework/slsa-github-generator/*",
        "softprops/action-gh-release@*"
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
  _repositories+:: [
    orgs.newRepo('.github') {
      local thisRepo = self,
      allow_merge_commit: true,
      allow_update_branch: false,
      default_branch: "master",
      delete_branch_on_merge: false,
      dependabot_security_updates_enabled: true,
      description: "Global configurations for the eclipse-cbi GitHub organization",
      workflows+: {
        allow_action_patterns+: [
          "ludeeus/action-shellcheck@*",
          "marocchino/sticky-pull-request-comment@*",
          "release-drafter/release-drafter@*",
          "slsa-framework/slsa-github-generator/*",
          "softprops/action-gh-release@*"
        ],
        allowed_actions: "selected",
        default_workflow_permissions: "write",
      },
      branch_protection_rules: [
        newBranchProtectionRule(thisRepo.default_branch),
      ],
    },
    orgs.extendRepo('.eclipsefdn') {
      local thisRepo = self,
      workflows+: {
        allow_action_patterns+: [
          "ludeeus/action-shellcheck@*",
          "marocchino/sticky-pull-request-comment@*",
          "release-drafter/release-drafter@*",
          "slsa-framework/slsa-github-generator/*",
          "softprops/action-gh-release@*"
        ],
        allowed_actions: "selected",
        default_workflow_permissions: "write",
      },
    },
    orgs.newRepo('ansible-playbooks') {
      local thisRepo = self,
      allow_merge_commit: true,
      allow_update_branch: false,
      delete_branch_on_merge: false,
      dependabot_security_updates_enabled: true,
      description: "Ansible playbooks for CBI",
      workflows+: {
        allow_action_patterns+: [
          "ludeeus/action-shellcheck@*",
          "marocchino/sticky-pull-request-comment@*",
          "release-drafter/release-drafter@*",
          "slsa-framework/slsa-github-generator/*",
          "softprops/action-gh-release@*"
        ],
        allowed_actions: "selected",
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
      delete_branch_on_merge: false,
      dependabot_security_updates_enabled: true,
      description: "Collection of best practices for Common Build Infrastructure",
      workflows+: {
        allow_action_patterns+: [
          "ludeeus/action-shellcheck@*",
          "marocchino/sticky-pull-request-comment@*",
          "release-drafter/release-drafter@*",
          "slsa-framework/slsa-github-generator/*",
          "softprops/action-gh-release@*"
        ],
        allowed_actions: "selected",
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
      delete_branch_on_merge: false,
      dependabot_security_updates_enabled: true,
      workflows+: {
        allow_action_patterns+: [
          "ludeeus/action-shellcheck@*",
          "marocchino/sticky-pull-request-comment@*",
          "release-drafter/release-drafter@*",
          "slsa-framework/slsa-github-generator/*",
          "softprops/action-gh-release@*"
        ],
        allowed_actions: "selected",
        default_workflow_permissions: "write",
      },
      branch_protection_rules: [
        newBranchProtectionRule(thisRepo.default_branch),
      ],
    },
    orgs.newRepo('ci-admin') {
      local thisRepo = self,
      allow_squash_merge: false,
      allow_update_branch: false,
      default_branch: "master",
      delete_branch_on_merge: false,
      dependabot_security_updates_enabled: true,
      workflows+: {
        allow_action_patterns+: [
          "ludeeus/action-shellcheck@*",
          "marocchino/sticky-pull-request-comment@*",
          "release-drafter/release-drafter@*",
          "slsa-framework/slsa-github-generator/*",
          "softprops/action-gh-release@*"
        ],
        allowed_actions: "selected",
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
      delete_branch_on_merge: false,
      dependabot_security_updates_enabled: true,
      description: "Various Dockerfiles for building stuff @ Eclipse",
      workflows+: {
        allow_action_patterns+: [
          "ludeeus/action-shellcheck@*",
          "marocchino/sticky-pull-request-comment@*",
          "release-drafter/release-drafter@*",
          "slsa-framework/slsa-github-generator/*",
          "softprops/action-gh-release@*"
        ],
        allowed_actions: "selected",
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
      delete_branch_on_merge: false,
      dependabot_security_updates_enabled: true,
      workflows+: {
        allow_action_patterns+: [
          "ludeeus/action-shellcheck@*",
          "marocchino/sticky-pull-request-comment@*",
          "release-drafter/release-drafter@*",
          "slsa-framework/slsa-github-generator/*",
          "softprops/action-gh-release@*"
        ],
        allowed_actions: "selected",
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
      delete_branch_on_merge: false,
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
        allow_action_patterns+: [
          "ludeeus/action-shellcheck@*",
          "marocchino/sticky-pull-request-comment@*",
          "release-drafter/release-drafter@*",
          "slsa-framework/slsa-github-generator/*",
          "softprops/action-gh-release@*"
        ],
        allowed_actions: "selected",
        default_workflow_permissions: "write",
      },
      branch_protection_rules: [
        newBranchProtectionRule(thisRepo.default_branch),
      ],
    },
    orgs.newRepo('epl-license-feature') {
      local thisRepo = self,
      allow_merge_commit: true,
      allow_update_branch: false,
      delete_branch_on_merge: false,
      dependabot_security_updates_enabled: true,
      workflows+: {
        allow_action_patterns+: [
          "ludeeus/action-shellcheck@*",
          "marocchino/sticky-pull-request-comment@*",
          "release-drafter/release-drafter@*",
          "slsa-framework/slsa-github-generator/*",
          "softprops/action-gh-release@*"
        ],
        allowed_actions: "selected",
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
        allow_action_patterns+: [
          "ludeeus/action-shellcheck@*",
          "marocchino/sticky-pull-request-comment@*",
          "release-drafter/release-drafter@*",
          "slsa-framework/slsa-github-generator/*",
          "softprops/action-gh-release@*"
        ],
        allowed_actions: "selected",
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
        allow_action_patterns+: [
          "ludeeus/action-shellcheck@*",
          "marocchino/sticky-pull-request-comment@*",
          "release-drafter/release-drafter@*",
          "slsa-framework/slsa-github-generator/*",
          "softprops/action-gh-release@*"
        ],
        allowed_actions: "selected",
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
      description: "Jenkins agents for projects hosted by the Eclipse Foundation",
      homepage: "",
      workflows+: {
        allow_action_patterns+: [
          "ludeeus/action-shellcheck@*",
          "marocchino/sticky-pull-request-comment@*",
          "release-drafter/release-drafter@*",
          "slsa-framework/slsa-github-generator/*",
          "softprops/action-gh-release@*"
        ],
        allowed_actions: "selected",
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
        allow_action_patterns+: [
          "ludeeus/action-shellcheck@*",
          "marocchino/sticky-pull-request-comment@*",
          "release-drafter/release-drafter@*",
          "slsa-framework/slsa-github-generator/*",
          "softprops/action-gh-release@*"
        ],
        allowed_actions: "selected",
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
        allow_action_patterns+: [
          "ludeeus/action-shellcheck@*",
          "marocchino/sticky-pull-request-comment@*",
          "release-drafter/release-drafter@*",
          "slsa-framework/slsa-github-generator/*",
          "softprops/action-gh-release@*"
        ],
        allowed_actions: "selected",
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
        allow_action_patterns+: [
          "ludeeus/action-shellcheck@*",
          "marocchino/sticky-pull-request-comment@*",
          "release-drafter/release-drafter@*",
          "slsa-framework/slsa-github-generator/*",
          "softprops/action-gh-release@*"
        ],
        allowed_actions: "selected",
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
        allow_action_patterns+: [
          "ludeeus/action-shellcheck@*",
          "marocchino/sticky-pull-request-comment@*",
          "release-drafter/release-drafter@*",
          "slsa-framework/slsa-github-generator/*",
          "softprops/action-gh-release@*"
        ],
        allowed_actions: "selected",
        default_workflow_permissions: "write",
      },
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
    orgs.newRepo('org.eclipse.cbi') {
      local thisRepo = self,
      dependabot_security_updates_enabled: true,
      description: "CBI Maven plugins and Webservices",
      workflows+: {
        allow_action_patterns+: [
          "ludeeus/action-shellcheck@*",
          "marocchino/sticky-pull-request-comment@*",
          "release-drafter/release-drafter@*",
          "slsa-framework/slsa-github-generator/*",
          "softprops/action-gh-release@*"
        ],
        allowed_actions: "selected",
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
        allow_action_patterns+: [
          "ludeeus/action-shellcheck@*",
          "marocchino/sticky-pull-request-comment@*",
          "release-drafter/release-drafter@*",
          "slsa-framework/slsa-github-generator/*",
          "softprops/action-gh-release@*"
        ],
        allowed_actions: "selected",
        default_workflow_permissions: "write",
      },
      branch_protection_rules: [
        newBranchProtectionRule(thisRepo.default_branch),
      ],
    },
    orgs.newRepo('p2repo-aggregator') {
      local thisRepo = self,
      allow_merge_commit: true,
      allow_update_branch: false,
      delete_branch_on_merge: false,
      dependabot_security_updates_enabled: true,
      workflows+: {
        allow_action_patterns+: [
          "ludeeus/action-shellcheck@*",
          "marocchino/sticky-pull-request-comment@*",
          "release-drafter/release-drafter@*",
          "slsa-framework/slsa-github-generator/*",
          "softprops/action-gh-release@*"
        ],
        allowed_actions: "selected",
        default_workflow_permissions: "write",
      },
      branch_protection_rules: [
        newBranchProtectionRule(thisRepo.default_branch),
      ],
    },
    orgs.newRepo('p2repo-analyzers') {
      local thisRepo = self,
      allow_merge_commit: true,
      allow_update_branch: false,
      delete_branch_on_merge: false,
      dependabot_security_updates_enabled: true,
      workflows+: {
        allow_action_patterns+: [
          "ludeeus/action-shellcheck@*",
          "marocchino/sticky-pull-request-comment@*",
          "release-drafter/release-drafter@*",
          "slsa-framework/slsa-github-generator/*",
          "softprops/action-gh-release@*"
        ],
        allowed_actions: "selected",
        default_workflow_permissions: "write",
      },
      branch_protection_rules: [
        newBranchProtectionRule(thisRepo.default_branch),
      ],
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
        allow_action_patterns+: [
          "ludeeus/action-shellcheck@*",
          "marocchino/sticky-pull-request-comment@*",
          "release-drafter/release-drafter@*",
          "slsa-framework/slsa-github-generator/*",
          "softprops/action-gh-release@*"
        ],
        allowed_actions: "selected",
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
        allow_action_patterns+: [
          "ludeeus/action-shellcheck@*",
          "marocchino/sticky-pull-request-comment@*",
          "release-drafter/release-drafter@*",
          "slsa-framework/slsa-github-generator/*",
          "softprops/action-gh-release@*"
        ],
        allowed_actions: "selected",
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
  ],
}
