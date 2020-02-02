# AWS-LAMBDA-EDGE-IMG2WEBP

## 注意事项

0. Lambda@Edge必须在us-east-1区域部署才行，其他区域无此功能，部署后可以同步到全球各区域的CloudFront关联，如果要删除则必须先全部取消CloudFront Lambda关联才能自行删除。
1. Lambda@Edge查看器请求zip包不能超过1MB，也就是说查看器函数不能调用过大的Nodejs包，否则node_modules包就会超出1MB。还需要注意Nodejs版本支持，目前最高支持`nodejs10.x`。
2. 给IAM角色赋予S3写入读取权限。
3. 如果是同一账号，只要给Lambda的执行角色赋予S3操作权限，则无需加入S3 Bucket存储桶策略，否则需要加入相关策略，具体可通过这个工具生成：<https://awspolicygen.s3.amazonaws.com/policygen.html>
4. 如果还是无法访问S3，请检阅此文件：<https://aws.amazon.com/cn/premiumsupport/knowledge-center/lambda-execution-role-s3-bucket/>
5. 如果还是不行，则只能通过Lambda测试来发现问题，日志可在CloudWatch查看相关日志流（需注意S3区域，不同用户从不同区域访问CloudFront，日志会放入相关区域的CloudWatch中），也可以通过CloudFront Monitoring查看聚合日志统计。
6. 如果存储桶是私有的，则Lambda在判定对象是否存在时返回的**是403而不是404**，这是有意义的，因为可以防止攻击者去枚举桶中的数据。具体查看：<https://stackoverflow.com/questions/50008445/aws-cloudfront-returns-access-denied-from-s3-origin-with-query-string>。
7. 通过日志观察函数执行时间和内存消耗来调整内存大小和最大执行时间优化服务可用性。
