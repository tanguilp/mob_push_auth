# MobPushAuth

This is a demo Phoenix app that shows how to use Web Push notification
to authenticate users.

The flow involves 2 steps:
1. Registration: on a computer, a user opens a QR code on his/her phone. The
user accepts push notifications to be sent on his/her phone
2. Authentication: on a computer, the user enters his/her login. A web push
notification is sent to his/her phone with a link. The link opens a web
page asking for authentication confirmation. Upon acceptance, the user is
authenticated on the computer

[Demo video](https://vimeo.com/798029707)

This demo is deployed on
[https://mob-push-auth.onrender.com/](https://mob-push-auth.onrender.com/).
This is a free tiers and it can take a few minutes to start.

This is **not ready** for production use. Security model is not documented.
That's just about sharing ideas :)

## Support

As of February, 2023:
- doesn't work on iOS
- works on Android with Chrome
- doesn't work with Android and Firefox or Mi Browser
