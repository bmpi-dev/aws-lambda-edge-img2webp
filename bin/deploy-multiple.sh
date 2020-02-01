NAME=my-sam-package
S3_BUCKET=img.bmpi.dev
RESOURCES=services
ARCHIVE_NAME=resources.zip
TEMPLATE_FILE=sam.yaml
OUTPUT_TEMPLATE_FILE=sam-output.yaml
ENVIRONMENT=production
AWS_PROFILE=default
REGIONS=( "us-east-1" "us-east-2" "us-west-1" "us-west-2")

STACK_NAME=${ENVIRONMENT}-${NAME}

for REGION in "${REGIONS[@]}"
do
   :
   aws s3 mb s3://${S3_BUCKET}-${REGION} \ # append region name to create a separate bucket
    --region ${REGION}

   aws cloudformation package \
    --template-file ${TEMPLATE_FILE} \
    --output-template-file ${OUTPUT_TEMPLATE_FILE} \
    --s3-bucket ${S3_BUCKET}-${REGION} \
    --region ${REGION}
    ${PROFILE}

   aws cloudformation deploy \
    --template-file ${OUTPUT_TEMPLATE_FILE} \
    --stack-name ${STACK_NAME} \
    --capabilities ${CAPABILITIES} \
    --region ${REGION} \
    ${PROFILE}
done