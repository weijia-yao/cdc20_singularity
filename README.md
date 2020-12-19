# Vector Field Guided Path Following Control: Singularity Elimination and Global Convergence (CDC20)
## Simulation code and data

| File name    | Category            | Description                   |
| ------------ | ------------------- | ----------------------------- |
| pf_sim.slx   | path following      | Simulink file for simulation; |
| pf_plot.m    | path following      | Matlab file for plotting;     |
| pf_animate.m | path following      | Matlab file for animation;    |
| tt_sim.slx   | trajectory tracking | Simulink file for simulation; |
| tt_plot.m    | trajectory tracking | Matlab file for plotting;     |
| tt_animate.m | trajectory tracking | Matlab file for animation;    |

We use Simulink in Matlab R2018b, but we have not tested other versions of Simulink and Matlab.

For convenience, you could directly download the data files<sup>1</sup> from [here](https://drive.google.com/open?id=1bvGdsDeV_ZGX0BHK6cfYCEdCxeM6KAby), and use the "plot" or "animation" Matlab files above to see the effects. The details of the data files are shown below.


| Name             | Category            | Description                                      |
| ---------------- | ------------------- | ------------------------------------------------ |
| 11_noise0pf.mat  | path following      | without white noise                              |
| 11_noise10pf.mat | path following      | with white noise (power: 10, sampling time: 0.1) |
| 13_noise0tt.mat  | trajectory tracking | without white noise                              |
| 13_noise10tt.mat | trajectory tracking | with white noise (power: 10, sampling time: 0.1) |


<sup>1</sup> The reason that these files are big is we used very small fixed simulation time step to obtain accurate results. But this is actually not necessary, one can ignore these data files and instead use dynamic simulation time step, which will reduce the simulation time significantly and produce basically the same results.


## Video
The video can be accessed by clicking the image below:

[![](fig/video_preface.png)](https://www.youtube.com/watch?v=LfXCNdyBaTs)

# Extension
More details of creating singularity-free guiding vector fields in a higher-dimensional space can be found [here](http://tiny.cc/yao_singularity). To see experiments with a fixed-wing UAV, Click this link: [Singularity-free Guiding Vector Field for Robot Navigation](https://www.youtube.com/watch?v=jxWPsm0g-Ro&feature=youtu.be)

Open source code implemented in [Paparazzi](http://wiki.paparazziuav.org/wiki/Main_Page): [Code](https://github.com/noether/paparazzi/tree/gvf_advanced/sw/airborne/modules/guidance/gvf_parametric).

