# Robot-Path-Planning-using-Robust-MDP

# Introduction
  -->Optimal solutions of MDP are sensitive to the state transition probabilities. 
  
  -->Estimation of the state transition probabilities are far from accurate in real life situations.
  
  -->Which limits the usage of MDP in real life problems

# Motivation

  -->The aim is to build the robust control strategy for finite state and finite action MDP’s when transition probabilities are uncertain.
  
  -->The solution could be obtained using variant of the classical dynamic programming algorithm, the “robust dynamic programming” algorithm.
  
# Model Enviornment 
![1](https://user-images.githubusercontent.com/85469834/186828935-0cab08b5-c1fe-4046-81cd-9dbfc4eba0ce.jpg)

![Screenshot 2022-08-26 104629](https://user-images.githubusercontent.com/85469834/186828941-397f7d93-033e-4bbb-91f9-6be8d4e10f48.jpg)
# Robust Value Iteration
  1) Initialize **V** to zero vector as the size of the state space.
  
  2) Repeat Until **V** Converges.
  
  3) For all States **i** and control a assign to matrix **Q<sub>min</sub>** the solution to the optimization problem.
  
        Q<sub>min(i, a)</sub> = min(E<sub>p</sub>[R(i)+p<sup>t</sup>V] )  ∀ (p∈P<sub>i</sub><sup>a</sup>)
  4) Update V by maximizing over the control set:
  
        V(i) = max( Q<sub>min(i,a)</sub> )  ∀ (a∈A)


# Results and conclusion

1) Cost = (returns under certainty - returns under uncertainty)
2) We can observe that the cost of the nominal policy increases more than that of robust policy.
3) Intercept of nominal policy is close to close to zero under no uncertain which implies under certainty nominal policy behaves optimally.
4) While in the case of robust intercept is high which tells that robust strategy behave suboptimally.
5) As the uncertainty increases the robust strategy behaves better than that nominal strategy, which can be concluded from the slopes of the above graphs


#Nominal MDP results

<img src="https://user-images.githubusercontent.com/85469834/184289982-401e2578-061c-4217-83e1-b57adb8cefb3.jpg" width="600" height="450">

#Robust MDP results

<img src="https://user-images.githubusercontent.com/85469834/184289913-1687707d-4c08-4ec6-8cdd-ba0ba7b107ba.jpg" width="600" height="450">
