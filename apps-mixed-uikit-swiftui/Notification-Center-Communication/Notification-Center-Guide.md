### Overviews:

### NotificationCenter + Observer vs Delegate + Protocol:
Delegate + Protocol (Delegation) is for one to one communication, but, NotificationCenter + Observer is for one to many.

Multiple Observers from different places of the codebase can be set on a a Single Notification, to perform action when the state changes.