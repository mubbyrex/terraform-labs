# Terraform Labs

This repo is my Terraform playground.

I use it to learn, test ideas, and go deeper into concepts by actually building things.

---

## 📦 Structure

```id="z8z6nh"
terraform-labs/
├── shared/
│   └── backend/          # reusable backend configs
├── exercises/
│   ├── 01-submodules/
│   ├── 02-remote-state/
│   ├── 03-multi-account/
│   └── ...
└── projects/
    ├── mini-platform/
    └── eks-environment/
```

---

## How I use this repo

### 🧪 Exercises

Each folder focuses on a single concept.

* Learn the concept
* Build something small around it
* Break things and fix them
* Understand how it behaves in real scenarios

---

### Projects

This is where I combine multiple concepts into something more realistic.

Think:

* multi-environment setups
* reusable modules
* CI/CD-style workflows (simulated)

---

### Shared

Stuff I don’t want to repeat everywhere.

Right now:

* backend configs (S3, state setup, etc.)

---

## Notes

* Things might be incomplete or messy sometimes
* I intentionally experiment and break stuff here

