from django.contrib.auth.decorators import login_required
from django.shortcuts import render


# -------------------------------------  Branch offices -------------------------------------
@login_required(login_url='users:login')
def branch_offices(request):
    template = 'branchoffices/branch-offices.html'
    context = {
        'page_title': 'Dabbawala'
    }
    return render(request, template, context)


def contact(request):
      template = 'contact.html'
      context = {}
      return render(request, template, context)

def job(request):
    template = 'job.html'
    context = {}
    return render(request, template, context)
