local orgs = import 'vendor/otterdog-defaults/otterdog-defaults.libsonnet';

orgs.newOrg('eclipse-cbi') {
  settings+: {
    billing_email: "webmaster@eclipse.org",
    blog: "https://projects.eclipse.org/projects/technology.cbi",
    default_repository_permission: "none",
    default_workflow_permissions: "write",
    description: "The Eclipse CBI project",
    email: "cbi-dev@eclipse.org",
    location: "Belgium",
    name: "Eclipse CBI",
    packages_containers_internal: false,
    readers_can_create_discussions: true,
    security_managers+: [
      "technology-cbi-project-leads"
    ],
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
      allow_update_branch: false,
      default_branch: "master",
      dependabot_security_updates_enabled: true,
      description: "Global configurations for the eclipse-cbi GitHub organization",
      secret_scanning: "disabled",
      secret_scanning_push_protection: "disabled",
    },
    orgs.newRepo('ansible-playbooks') {
      allow_update_branch: false,
      dependabot_security_updates_enabled: true,
      description: "Ansible playbooks for CBI",
      secret_scanning: "disabled",
      secret_scanning_push_protection: "disabled",
    },
    orgs.newRepo('best-practices') {
      allow_update_branch: false,
      dependabot_security_updates_enabled: true,
      description: "Collection of best practices for Common Build Infrastructure",
      secret_scanning: "disabled",
      secret_scanning_push_protection: "disabled",
    },
    orgs.newRepo('buildkitd-okd') {
      allow_update_branch: false,
      dependabot_security_updates_enabled: true,
      secret_scanning: "disabled",
      secret_scanning_push_protection: "disabled",
    },
    orgs.newRepo('ci-admin') {
      allow_merge_commit: false,
      allow_squash_merge: false,
      allow_update_branch: false,
      default_branch: "master",
      dependabot_security_updates_enabled: true,
      secret_scanning: "disabled",
      secret_scanning_push_protection: "disabled",
    },
    orgs.newRepo('dockerfiles') {
      allow_update_branch: false,
      default_branch: "master",
      dependabot_security_updates_enabled: true,
      description: "Various Dockerfiles for building stuff @ Eclipse",
      secret_scanning: "disabled",
      secret_scanning_push_protection: "disabled",
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
    },
    orgs.newRepo('dockertools') {
      allow_update_branch: false,
      default_branch: "master",
      dependabot_security_updates_enabled: true,
      secret_scanning: "disabled",
      secret_scanning_push_protection: "disabled",
    },
    orgs.newRepo('eclipse-cbi-tycho-example') {
      allow_update_branch: false,
      dependabot_security_updates_enabled: true,
      description: "Eclipse CBI Tycho example project",
      homepage: "",
      secret_scanning: "disabled",
      secret_scanning_push_protection: "disabled",
      topics+: [
        "cbi",
        "eclipse",
        "example",
        "maven",
        "tycho"
      ],
    },
    orgs.newRepo('epl-license-feature') {
      allow_update_branch: false,
      dependabot_security_updates_enabled: true,
      secret_scanning: "disabled",
      secret_scanning_push_protection: "disabled",
    },
    orgs.newRepo('hipp2jipp') {
      archived: true,
      default_branch: "master",
      description: "A tool that converts Hudson config files to make them compatible with Jenkins",
      homepage: "",
      secret_scanning: "disabled",
      topics+: [
        "cbi",
        "config",
        "conversion",
        "hudson",
        "jenkins",
        "migration"
      ],
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
      allow_merge_commit: false,
      allow_squash_merge: false,
      allow_update_branch: false,
      default_branch: "master",
      delete_branch_on_merge: true,
      dependabot_security_updates_enabled: true,
      description: "Jenkins infrastructure for projects hosted by the Eclipse Foundation",
      secret_scanning: "disabled",
      secret_scanning_push_protection: "disabled",
    },
    orgs.newRepo('jiro-agents') {
      allow_merge_commit: false,
      allow_squash_merge: false,
      allow_update_branch: false,
      default_branch: "master",
      delete_branch_on_merge: true,
      dependabot_security_updates_enabled: true,
      description: "Jenkins agents for projects hosted by the Eclipse Foundation",
      homepage: "",
      secret_scanning: "disabled",
      secret_scanning_push_protection: "disabled",
    },
    orgs.newRepo('jiro-dashboard') {
      allow_update_branch: false,
      default_branch: "master",
      dependabot_security_updates_enabled: true,
      secret_scanning: "disabled",
      secret_scanning_push_protection: "disabled",
    },
    orgs.newRepo('jiro-masters') {
      allow_merge_commit: false,
      allow_squash_merge: false,
      allow_update_branch: false,
      default_branch: "master",
      delete_branch_on_merge: true,
      dependabot_security_updates_enabled: true,
      description: "Jenkins master (base) images for projects hosted by the Eclipse Foundation",
      homepage: "",
      secret_scanning: "disabled",
      secret_scanning_push_protection: "disabled",
    },
    orgs.newRepo('jiro-static-agents') {
      allow_update_branch: false,
      dependabot_security_updates_enabled: true,
      secret_scanning: "disabled",
      secret_scanning_push_protection: "disabled",
    },
    orgs.newRepo('macos-notarization-service') {
      allow_merge_commit: false,
      allow_squash_merge: false,
      allow_update_branch: false,
      delete_branch_on_merge: true,
      dependabot_security_updates_enabled: true,
      description: "REST Service to notarize macOS application bundles and DMG",
      has_discussions: true,
      homepage: "",
      secret_scanning: "disabled",
      secret_scanning_push_protection: "disabled",
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
        orgs.newBranchProtectionRule('main') {
          required_approving_review_count: null,
          requires_pull_request: false,
          requires_status_checks: false,
          requires_strict_status_checks: true,
        },
      ],
    },
    orgs.newRepo('org.eclipse.cbi') {
      delete_branch_on_merge: true,
      dependabot_security_updates_enabled: true,
      description: "CBI Maven plugins and Webservices",
      secret_scanning: "disabled",
      secret_scanning_push_protection: "disabled",
    },
    orgs.newRepo('org.eclipse.cbi-testdata') {
      allow_update_branch: false,
      dependabot_security_updates_enabled: true,
      secret_scanning: "disabled",
      secret_scanning_push_protection: "disabled",
    },
    orgs.newRepo('p2repo-aggregator') {
      allow_update_branch: false,
      dependabot_security_updates_enabled: true,
      secret_scanning: "disabled",
      secret_scanning_push_protection: "disabled",
    },
    orgs.newRepo('p2repo-analyzers') {
      allow_update_branch: false,
      dependabot_security_updates_enabled: true,
      secret_scanning: "disabled",
      secret_scanning_push_protection: "disabled",
    },
    orgs.newRepo('sonatype-nexus') {
      allow_update_branch: false,
      default_branch: "master",
      dependabot_security_updates_enabled: true,
      description: "Docker images and Kubernetes deployment files for Sonatype Nexus repositories hosted by the Eclipse Foundation",
      secret_scanning: "disabled",
      secret_scanning_push_protection: "disabled",
    },
    orgs.newRepo('targetplatform-dsl') {
      allow_merge_commit: false,
      allow_squash_merge: false,
      allow_update_branch: false,
      default_branch: "master",
      delete_branch_on_merge: true,
      dependabot_security_updates_enabled: true,
      description: "Target Platform Definition DSL and Generator",
      homepage: "",
      secret_scanning: "disabled",
      secret_scanning_push_protection: "disabled",
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
      environments: [
        orgs.newEnvironment('github-pages'),
      ],
    },
  ],
}
