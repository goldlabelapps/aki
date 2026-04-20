// start.mjs — cross-platform launcher for AKI
// Works on macOS, Linux, and Windows.

import { spawn } from 'child_process';
import open from 'open';

const isWindows = process.platform === 'win32';
const shell = isWindows ? 'cmd' : 'sh';
const shellFlag = isWindows ? '/c' : '-c';

/**
 * Spawn a yarn script as a child process, inheriting stdio so all output
 * flows through to the current terminal.
 */
function runScript(script) {
  console.log(`[AKI] Starting: yarn ${script}`);
  const child = spawn(shell, [shellFlag, `yarn ${script}`], {
    stdio: 'inherit',
    cwd: process.cwd(),
  });
  child.on('error', (err) => {
    console.error(`[AKI] Failed to start "yarn ${script}":`, err.message);
  });
  return child;
}

// Start Ollama server and the chosen model
runScript('ollama');

// Switch the comment below to use a different model
runScript('phi3');
// runScript('codellama');

// Start the frontend and backend dev servers
runScript('frontend');
runScript('backend');

// Open the browser once the servers have had time to boot
setTimeout(() => {
  const targetUrl = 'http://localhost:1975/database/table/pdfs';
  console.log(`[AKI] Opening ${targetUrl}`);
  open(targetUrl);
}, 5000);
