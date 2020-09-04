import { ISolidityCIClient } from '../app/interfaces';
import { Artifacts } from '../app-domain';
import { getApiBaseUrl } from './utils';
import fetch from 'node-fetch';
import fs from 'fs';
import util from 'util';
import path from 'path';

const readFileAsync = util.promisify(fs.readFile);

export const solidityciClient: ISolidityCIClient = {
    async readsolidityciConfig() {
        const solidityciJsonPath = path.join('.solidity-ci', 'solidityci.json');
        if (!fs.existsSync(solidityciJsonPath)) {
            throw new Error(`Expected solidityci info file "${solidityciJsonPath}" does no exist, please configure your CI/CD Package.`);
        }
        const fileContent = await readFileAsync(solidityciJsonPath);
        return JSON.parse(fileContent.toString());
    },

    async saveArtifacts(artifactsObject: Artifacts, token: string): Promise<void> {
        const artifactsUrl = `${getApiBaseUrl()}/soliditycis/${artifactsObject.solidityciId}/artifacts`;

        const response = await fetch(artifactsUrl, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'project-token': token
            },
            body:  JSON.stringify(artifactsObject.artifactsList),
        });

        if (response.ok) {
            console.log('[SolidityCI Artifacts] solidityci compile artifects and runtests have been saved!');
        } else {
            const error = await response.text();
            throw new Error(`[SolidityCI Artifacts] cannot save artifects and runtests ${error}`);
        }
    }
};