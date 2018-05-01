from __future__ import print_function
import os, sys
import matplotlib.pyplot as plt
import numpy as np
import lsqfit
import gvar as gv
plt.rc('text', usetex=True)

a_lst = ['a15','a12','a09']
clrs = {'a15':'#ec5d57','a12':'#70bf41','a09':'#51a7f9'}
mrkr = {'a15':'s','a12':'h','a09':'o'}
gr = 1.618034333
figsize=(7,7./gr)

'''
The data are ordered from heaviest to ligthest quark mass
'''
gV = {
    'a15':np.array(gv.gvar([0.998,0.997,1.001,1.000,0.994],[0.001,0.001,0.002,0.004,0.035])),
    'a12':np.array(gv.gvar([1.016,1.016,1.021,1.015,1.020],[.001,.001,.002,.002,.008])),
    'a09':np.array(gv.gvar([1.023,1.024,1.024,1.022],[0.001,0.002,0.001,0.002]))
}
mq = {
    'a15':np.array([0.0278,0.0206,0.0158,0.00712,0.00216])+np.array([9.365e-04,9.38e-4,9.546e-4,5.726e-4,2.539e-4]),
    'a12':np.array([.0219,.0166,.0126,.006,.00195])+np.array([7.316e-4,7.559e-4,7.681e-4,4.032e-4,1.641e-4]),
    'a09':np.array([0.0160,0.0121,0.00951,0.00449])+np.array([2.511e-4,2.536e-4,2.671e-4,1.652e-4])
}

priors = {
    'a15':{'gV0':gv.gvar(1,.1),'gV1':gv.gvar(0,1)},
    'a12':{'gV0':gv.gvar(1,.1),'gV1':gv.gvar(0,1)},
    'a09':{'gV0':gv.gvar(1,.1),'gV1':gv.gvar(0,1)}}
def fit_function(x,p):
    return np.ones_like(x) * p['gV0']
def fit_function1(x,p):
    return np.ones_like(x) * p['gV0'] + p['gV1'] * x


plt.ion()
for a in a_lst:
    fig = plt.figure('gV_'+a,figsize=figsize)
    ax = plt.axes([0.14,0.14,.8,.8])
    x = mq[a]
    y = gV[a]
    print('===============================================================')
    print(a)

    ''' mpi <= 310 '''
    mq_plot = np.arange(0,1.11*max(x[2:]),.001)
    print('\n##########################################')
    print('    mpi <= 310: gV = gV_0')
    print('##########################################')
    fit = lsqfit.nonlinear_fit(data=(x[2:],y[2:]),prior=priors[a],fcn=fit_function)
    g0  = fit.p['gV0'].mean
    dg0 = fit.p['gV0'].sdev
    print(fit)
    print('Z_V^2['+a+'] = ',1/fit.p['gV0']**2)
    ax.plot(mq_plot,g0-dg0+0*mq_plot,color='k',alpha=0.6,linestyle='--')
    ax.plot(mq_plot,g0+dg0+0*mq_plot,color='k',alpha=0.6,linestyle='--')
    #ax.fill_between(mq_plot,g0-dg0,g0+dg0,color='k',alpha=0.4)

    print('\n##########################################')
    print('    mpi <= 310: gV = gV_0 + gV_1 * ml')
    print('##########################################')
    fit1 = lsqfit.nonlinear_fit(data=(x[2:],y[2:]),prior=priors[a],fcn=fit_function1)
    g_avg = np.array([f.mean for f in fit_function1(mq_plot,fit1.p)])
    g_sdv = np.array([f.sdev for f in fit_function1(mq_plot,fit1.p)])
    ax.fill_between(mq_plot,g_avg-g_sdv,g_avg+g_sdv,color='k',alpha=0.4)
    #ax.fill_between(mq_plot,g0-dg0,g0+dg0,color='k',alpha=0.4)
    print(fit1)
    print('Z_V^2['+a+'] = ',1/fit1.p['gV0']**2)

    ''' ALL data '''
    mq_plot = np.arange(0,1.11*max(x[0:]),.001)
    # CONST FIT
    print('\n##########################################')
    print('    mpi <= 400: gV = gV_0')
    print('##########################################')
    fit = lsqfit.nonlinear_fit(data=(x,y),prior=priors[a],fcn=fit_function)
    g0  = fit.p['gV0'].mean
    dg0 = fit.p['gV0'].sdev
    ax.plot(mq_plot,g0-dg0+0*mq_plot,color=clrs[a],alpha=0.6,linestyle='--')
    ax.plot(mq_plot,g0+dg0+0*mq_plot,color=clrs[a],alpha=0.6,linestyle='--')
    print(fit)
    print('Z_V^2['+a+'] = ',1/fit.p['gV0']**2)
    ax.errorbar(x,[g.mean for g in gV[a]],yerr=[g.sdev for g in gV[a]],\
        linestyle='None',color=clrs[a],marker=mrkr[a])


    # LINEAR FIT
    print('\n##########################################')
    print('    mpi <= 400: gV = gV_0 + gV_1 * ml')
    print('##########################################')
    fit1 = lsqfit.nonlinear_fit(data=(x[0:],y[0:]),prior=priors[a],fcn=fit_function1)
    g_avg = np.array([f.mean for f in fit_function1(mq_plot,fit1.p)])
    g_sdv = np.array([f.sdev for f in fit_function1(mq_plot,fit1.p)])
    ax.fill_between(mq_plot,g_avg-g_sdv,g_avg+g_sdv,color=clrs[a],alpha=0.4)
    print(fit1)
    print('Z_V^2['+a+'] = ',1/fit1.p['gV0']**2)




    ax.set_ylabel(r'$g_V$',fontsize=20)
    ax.set_xlabel(r'$am_l + am_l^{res}$',fontsize=20)
    ax.axis([0,1.1*max(mq[a]),0.98,1.04])
    if not os.path.exists('plots'):
        os.makedirs('plots')
    plt.savefig('plots/gV_'+a+'.pdf',transparent=True)

plt.ioff()
plt.show()
