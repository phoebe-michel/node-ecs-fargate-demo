# ECS Fargate + CloudFormation demo

This repo contains a minimal Node.js app, Dockerfile, a CloudFormation template that creates an ECR repo + ECS Fargate service behind an ALB, and a GitHub Actions workflow that builds and deploys.

## Quick flow:
1. GitHub Actions builds Docker image and pushes to the ECR repo that CloudFormation creates.
2. CloudFormation creates/updates an ECS Fargate service that uses that image (tag `latest`).
3. ALB URL is output by CloudFormation.

## Prerequisites:
- AWS account
- AWS user/role with permissions: CloudFormation, ECR, ECS, IAM (to create roles), EC2 (VPC/ALB), Logs
  - For practice, you can create an IAM user with broad permissions (Admin) temporarily — tighten later.
- GitHub repository and GitHub Secrets:
  - AWS_ACCESS_KEY_ID
  - AWS_SECRET_ACCESS_KEY
  - AWS_REGION (e.g. us-east-1)

## How to run locally:
1. Build and run locally:
   - docker build -t ecs-demo .
   - docker run -p 3000:3000 ecs-demo
   - curl http://localhost:3000

## Notes:
- The CloudFormation template creates an ECR repo named `ecs-fargate-demo-repo`.
- The GitHub Actions workflow tags and pushes the image to that repository as `:latest`.
- Clean up: delete the CloudFormation stack (this removes all resources created by the template).

## Cleanup:
- From CLI:
  - aws cloudformation delete-stack --stack-name ecs-fargate-demo
- Or delete the stack from the AWS Console.

Costs: The stack creates an ALB and Fargate tasks. Delete the stack when done to avoid charges.
