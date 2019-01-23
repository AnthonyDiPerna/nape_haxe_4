package nape;
/**
 * Configuration parameters for Nape
 */
@:final class Config{
    /**
     * @private
     */
    function new(){}
    /**
     * Generic epsilon value for float comparisons
     * <br/><br/>
     * @default 1e-8
     */
    public static var epsilon:Float=1e-8;
    /**
     * Parameter used in computing shape fluid angular drag coeffecient.
     * <br/><br/>
     * Defines the contribution to the drag coeffecient due to Material dynamicFriction
     * <br/><br/>
     * This global value must be set as the very first thing to ensure all Shapes
     * use your intended value.
     * <br/><br/>
     * This parameter has units kg/px
     * @default 2.5 kg/px
     */
    public static var fluidAngularDragFriction:Float=2.5;
    /**
     * Parameter used in computing shape fluid angular drag coeffecient.
     * <br/><br/>
     * Defines the contribution to the drag coeffecient due to shape's surface
     * area rotating into a fluid.
     * <br/><br/>
     * This global value must be set as the very first thing to ensure all Shapes
     * use your intended value.
     * <br/><br/>
     * This parameter has units kg/px
     * @default 100kg/px
     */
    public static var fluidAngularDrag:Float=100;
    /**
     * Parameter used in computing fluid drags.
     * <br/><br/>
     * Defines an added weight for scaling the contribution of forward drag due
     * to leaving a vaccuum behind the shape pulling it back.
     * <br/><br/>
     * This global value must be set as the very first thing to ensure all Shapes
     * use your intended value.
     * <br/><br/>
     * This parameter has no units.
     * @default 0.5
     */
    public static var fluidVacuumDrag:Float=0.5;
    /**
     * Parameter used in computing shapes linear drag in fluid.
     * <br/><br/>
     * Used in determining the amount of linear drag for the shape based on forward profile.
     * <br/><br/>
     * This parameter has units kg/px
     * @default 0.5kg/px
     */
    public static var fluidLinearDrag:Float=0.5;
    /**
     * Amount of overlap permitted between Shapes for collisions.
     * <br/><br/>
     * This parameter has units of pixels.
     * @default 0.2px
     */
    public static var collisionSlop:Float=0.2;
    /**
     * Amount of overlap permitted between Shapes before CCD kicks in.
     * <br/><br/>
     * This parameter has units of pixels, and should always be larger
     * than collisionSlop parameter.
     * @default 0.5px
     */
    public static var collisionSlopCCD:Float=0.5;
    /**
     * Biased distance treshold for CCD collisions.
     * <br/><br/>
     * In CCD collision routines, two Shapes will be considered intersecting
     * when the distance between them + collisionSlopCCD falls below this
     * value.
     * <br/><br/>
     * This parameter has units of pixels, and should always be > 0
     * @default 0.05px
     */
    public static var distanceThresholdCCD:Float=0.05;
    /**
     * Linear sweep threshold-ratio for static CCD collisions
     * <br/><br/>
     * In deciding what non-bullet objects should be collided continuously against
     * static/kinematic objects, the linear speed of the body is considered.
     * <code>
     * ccdCollide if: bodyLinearSpeed * deltaTime > threshold * bodyRadius
     * </code>
     * Intuitively, a value of 0.5 would mean that a body, in the worst case scenario
     * will be permitted to move half of its width in a single time step, before CCD
     * is enabled for this reason.
     * <br/><br/>
     * This parameter has no units.
     * @default 0.05
     */
    public static var staticCCDLinearThreshold:Float=0.05;
    /**
     * Angular sweep threshold for static CCD collisions
     * <br><br/>
     * In deciding what non-bullet objects should be collided continuously against
     * static/kinematic objects, the angular speed of the body is considered.
     * <code>
     * ccdCollide if: bodyAngularSpeed * deltaTime > threshold
     * </code>
     * Intuitively, a value of 0.5 would mean that a body would have to rotate more than
     * 0.5 radians in a single time step, before CCD is enabled for this reason. Noting that
     * at 60fps physics, the body would need an angularVel greater than 30rad/s for this
     * limit of 0.5 to be reached; the default is far smaller.
     * <br/><br/>
     * This parameter has units of rad.
     * @default 0.005rad
     */
    public static var staticCCDAngularThreshold:Float=0.005;
    /**
     * Linear sweep threshold-ratio for bullet CCD collisions
     * <br/><br/>
     * A dynamic body marked as a bullet, will not necessarigly always be collided
     * with continuously.
     * <br/><br/>
     * Should a body be moving, or rotating fast enough to pass the tests determined
     * by staticCCD#Threshold parameters, and is marked as a bullet, it must then
     * have its velocities checked against the equivalent bullet thresholds to actually
     * be collided continuously against other dynamic bodies too.
     * <br/><br/>
     * This parameter has no units.
     * @default 0.125
     */
    public static var bulletCCDLinearThreshold:Float=0.125;
    /**
     * Angular sweep threshold for bullet CCD collisions.
     * <br/><br/>
     * See description of bulletCCDLinearThreshold.
     * <br/><br/>
     * This parameter has units of rad.
     * @default 0.0125rad
     */
    public static var bulletCCDAngularThreshold:Float=0.0125;
    /**
     * Relative linear threshold for dynamic-dynamic sweeps.
     * <br/><br/>
     * When performing dynamic-dynamic sweep of Body shapes during CCD collision phase,
     * should the relative velocity of the bodies fall beneath this magnitude, they
     * may be considered (based on angular velocities also) to be moving together, and
     * this specific CCD test will be skipped.
     * <br/><br/>
     * This parameter has units of px/s
     * @default 17px/s
     */
    public static var dynamicSweepLinearThreshold:Float=17;
    /**
     * Relative angular bias threshold for dynamic-dynamic sweeps.
     * <br/><br/>
     * When performing dynamic-dynamic sweep of Body shapes during CCD collision phase,
     * should the relative angular velocity (weighted by the shape bias values) fall
     * beneath this magnitude, they may be considered (based on linear velocities also) to
     * be moving together, and this specific CCD test will be skipped.
     * <br/><br/>
     * The shape bias, is an internal value which indicates the 'amount of radius' of
     * a shape about the centre of rotation that can be considered to change under rotations.
     * eg: A circle at origin has a bias of 0 (Its rotation has no effect on sweeps)
     * whilst A circle far from the origin may have a large bias.
     * <br/><br/>
     * This parameter has units of px.rad/s
     * @default 0.6px.rad/s
     */
    public static var dynamicSweepAngularThreshold:Float=0.6;
    /**
     * Angular velocity scaling during CCD slips.
     * <br/><br/>
     * In rare cases, a Body can be moving in such a way that we fail to compute a perfect
     * time of impact; generally when a thin box-like object is rotating very quickly. The
     * time of impact solver in Nape attempts to avoid impacts which are seperating; so that
     * we can catch true impact times; but in a 'slip' case we are unable to achieve this and
     * to avoid a possible tunneling from the other side during later operations we will in
     * these rare cases scale down the angular velocity of a Body by this parameter.
     * <br/><br/>
     * This parameter has no units.
     * @default 0.75
     */
    public static var angularCCDSlipScale:Float=0.75;
    /**
     * Expiration delay length for collision arbiter destruction.
     * <br/><br/>
     * In unstable physics conditions, two colliding shapes may jitter such as to constantly
     * seperate, and then come back together again. This parameter controls the number of time
     * steps during which we will delay this destruction so that cached impulse values may
     * persist and improve stability of strenuous simulations.
     * <br/><br/>
     * This parameter has units of 'steps' I suppose.
     * @default 6steps
     */
    public static var arbiterExpirationDelay:Int=6;
    /**
     * Contact velocity threshold for static-dynamic friction
     * <br/><br/>
     * This is the threshold on projected contact velocities at which Nape will use
     * dynamic friction Mateiral values, in place of static friction Material values.
     * <br/><br/>
     * This parameter has units of px/s
     * @default 2px/s
     */
    public static var staticFrictionThreshold:Float=2;
    /**
     * Contact velocity threshold for elastic collisions
     * <br/><br/>
     * This is the threshold on weighted projected normal-contact velocities at which Nape will
     * decide to stop using elastic collisions. Nape will take the normal velocities at contact
     * and scale by the combined elasticity coeffecient for the Arbiter, if this value falls
     * below the threshold, then elasticity is ignored for stability in stacking.
     * <br/><br/>
     * This parameter has units of px/s
     * @default 20px/s
     */
    public static var elasticThreshold:Float=20;
    /**
     * Sleep delay for stationary bodies.
     * <br/><br/>
     * By default, Nape considers a body to be stationary even if it has a very small linear
     * or angular velocity. This parameter controls how many steps such a Body will continue
     * to be simulated for, before being put to sleep (Assuming everything else in the island
     * is also stationary for a sufficiently long time).
     * <br/><br/>
     * This parameter has units of 'steps' I suppose.
     * @default 60steps
     */
    public static var sleepDelay:Int=60;
    /**
     * Linear speed threshold for sleeping of Bodies.
     * <br/><br/>
     * A body in Nape will be considered stationary only if its linear velocity has magnitude
     * under this threshold.
     * <br/><br/>
     * This parameter has units of px/s
     * @default 0.2px/s
     */
    public static var linearSleepThreshold:Float=0.2;
    /**
     * Angular speed threshold for sleeping of Bodies.
     * <br/><br/>
     * A body in Nape will be considered stationary only if its angular velocity, multiplied
     * by the body radius (never under-estimated) about the origin, falls below this threshold.
     * <br/><br/>
     * The body radius scaling, ensures that a very large body needs to be rotating more slowly
     * to be considered stationary than a very small body. Intuitively we're designating this
     * a threshold on the maximum tangentenial velocity of the body due to rotation.
     * <br/><br/>
     * This parameter has units of px.rad/s
     * @default 0.4px.rad/s
     */
    public static var angularSleepThreshold:Float=0.4;
    /**
     * Fraction of contact slop resolved per-step for dynamic-dynamic discrete collisions.
     * <br/><br/>
     * This value determines, in the case of two non-continuously colliding dynamic objects
     * the fraction of the contact overlap that will attempt to be resolved during positional
     * iterations.
     * <br/><br/>
     * This parameter has units of 1/'step' I suppose.
     * @default 0.3/step
     */
    public static var contactBiasCoef:Float=0.3;
    /**
     * Fraction of contact slop resolved per-step for static/kinematic discrete collisions.
     * <br/><br/>
     * See description of contactBiasCoef; this is the coeffecient for non-continuous collisions
     * between a dynamic, and a static or kinematic object.
     * <br/><br/>
     * This parameter has units of 1/'step' I suppose.
     * @default 0.6/step
     */
    public static var contactStaticBiasCoef:Float=0.6;
    /**
     * Fraction of contact slop resolved per-step for dynamic-dynamic continuous collisions.
     * <br/><br/>
     * See description of contactBiasCoef; this is the coeffecient for continuous collisions
     * between two dynamic bodies.
     * <br/><br/>
     * This parameter has units of 1/'step' I suppose.
     * @default 0.4/step
     */
    public static var contactContinuousBiasCoef:Float=0.4;
    /**
     * Fraction of contact slop resolved per-step for static/kinematic continuous collisions.
     * <br/><br/>
     * See description of contactBiasCoef; this is the coeffecient for continuous collisions
     * between a dynamic, and a static or kinematic object.
     * <br/><br/>
     * This parameter has units of 1/'step' I suppose.
     * @default 0.5/step
     */
    public static var contactContinuousStaticBiasCoef:Float=0.5;
    /**
     * Amount of linear slop permitted in constraints.
     * <br/><br/>
     * A constraint will be considered to be 'relaxed' during positional iterations
     * only if the linear error falls below this threshold.
     * <br/><br/>
     * Assuming a 'sensible' constraint, this has units of px
     * @default 0.1px
     */
    public static var constraintLinearSlop:Float=0.1;
    /**
     * Amount of angular slop permitted in constraints.
     * <br/><br/>
     * A constraint will be considered to be 'relaxed' during positional iterations
     * only if the angular error falls below this threshold.
     * <br/><br/>
     * Assuming a 'sensible' constraint, this has units of rad
     * @default 1e-3rad
     */
    public static var constraintAngularSlop:Float=1e-3;
    /**
     * Ill-conditioned threshold for 2-contact collision constraints.
     * <br/><br/>
     * This is a threshold on the measure of ill-conditioning of the effective-mass-matrix
     * in a 2-contact collision at which the contact manifold will be forced into a 1-contact
     * constraint. This can occur quite readily when two contact points are almost exactly equal
     * or in certain other conditions where the mathematics quite simply breaks down when using
     * a block solver.
     * <br/><br/>
     * This parameter has no units.
     * @default 2e+8
     */
    public static var illConditionedThreshold:Float=2e+8;
}
