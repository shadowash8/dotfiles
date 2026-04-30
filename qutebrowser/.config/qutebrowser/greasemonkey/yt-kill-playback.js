// ==UserScript==
// @name         YouTube Kill Playback Only (Strict Scoped)
// @version      7.3.0
// @author       A S H (Modified)
// @match        *://*.youtube.com/*
// @run-at       document-start
// @grant        none
// ==/UserScript==

(() => {
    'use strict';

    // 🛑 GLOBAL CHECK: If not on YouTube, stop everything immediately
    if (!window.location.hostname.includes("youtube.com")) {
        return;
    }

    /* 1️⃣ HARD BLOCK play() - Only runs on YouTube due to check above */
    const realPlay = HTMLMediaElement.prototype.play;
    HTMLMediaElement.prototype.play = function() {
        this.pause();
        this.muted = true;
        this.volume = 0;
        return Promise.resolve();
    };

    /* 2️⃣ FORCE STOP VIDEO */
    const killVideo = v => {
        if (!v || v.paused) return;
        v.pause();
        v.muted = true;
        v.volume = 0;
        v.currentTime = 0;
        v.removeAttribute('src');
        v.load();
    };

    /* 3️⃣ OBSERVER SETUP */
    const startObserver = () => {
        const root = document.documentElement || document.body;
        if (!root) return false;

        new MutationObserver(muts => {
            for (const m of muts) {
                for (const n of m.addedNodes) {
                    if (n instanceof HTMLVideoElement) killVideo(n);
                    if (n.querySelectorAll)
                        n.querySelectorAll('video').forEach(killVideo);
                }
            }
        }).observe(root, {
            childList: true,
            subtree: true
        });

        return true;
    };

    /* 4️⃣ RETRY UNTIL DOM EXISTS */
    if (!startObserver()) {
        const retry = setInterval(() => {
            if (startObserver()) clearInterval(retry);
        }, 50);
    }

    /* 5️⃣ INITIAL PASS */
    document.addEventListener('DOMContentLoaded', () => {
        document.querySelectorAll('video').forEach(killVideo);
    });

    /* 6️⃣ SPA NAVIGATION */
    document.addEventListener('yt-navigate-finish', () => {
        document.querySelectorAll('video').forEach(killVideo);
    });
})();
