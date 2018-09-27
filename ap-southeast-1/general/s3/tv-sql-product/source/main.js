const https = require('https');

const targetHost = process.env.TARGET_HOST;// 'api-txtdev.test.tvlk.cloud'
const targetPort = process.env.TARGET_PORT;// 443
const targetPath = process.env.TARGET_PATH;// '/job/txt/job/scheduled'
const jobNames = process.env.JOB_NAMES.split(',');//'invalidateBookings';
const jobParams = process.env.JOB_PARAMS == undefined ? '[]' : process.env.JOB_PARAMS;

const hitApi = (jobName) => {
    const requestBody = JSON.stringify({
        jsonrpc: '2.0',
        id: '123',
        source: 'localhost',
        method: jobName,
        params: JSON.parse(jobParams)
    });

    const post_options = {
        host: targetHost,
        port: targetPort,
        path: targetPath,
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
            'Content-Length': Buffer.byteLength(requestBody)
        }
    };

    const req = https.request(post_options);
    req.write(requestBody);
    req.end();
};

exports.handler = (event, context, callback) => {
    jobNames.forEach((jobName) => {
        hitApi(jobName)
    });
    callback(null, 'SUCCESS');
};
