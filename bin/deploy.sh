NAME=my-sam-package
S3_BUCKET=img.bmpi.dev
RESOURCES=services
ARCHIVE_NAME=resources.zip
TEMPLATE_FILE=sam.yaml
OUTPUT_TEMPLATE_FILE=sam-output.yaml
ENVIRONMENT=production
AWS_PROFILE=default
REGION=us-east-1

STACK_NAME=${ENVIRONMENT}-${NAME}

aws s3 mb s3://${S3_BUCKET} \
 --region ${REGION}

aws cloudformation package \
 --template-file ${TEMPLATE_FILE} \
 --output-template-file ${OUTPUT_TEMPLATE_FILE} \
 --s3-bucket ${S3_BUCKET} \
 --region ${REGION}
 ${PROFILE}

aws cloudformation deploy \
 --template-file ${OUTPUT_TEMPLATE_FILE} \
 --stack-name ${STACK_NAME} \
 --capabilities ${CAPABILITIES} \
 --region ${REGION} \
 ${PROFILE}