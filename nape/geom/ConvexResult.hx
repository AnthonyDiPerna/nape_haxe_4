package nape.geom;
import zpp_nape.Const;
import zpp_nape.constraint.PivotJoint;
import zpp_nape.ID;
import zpp_nape.constraint.Constraint;
import zpp_nape.constraint.WeldJoint;
import zpp_nape.constraint.UserConstraint;
import zpp_nape.constraint.DistanceJoint;
import zpp_nape.constraint.LineJoint;
import zpp_nape.constraint.LinearJoint;
import zpp_nape.constraint.AngleJoint;
import zpp_nape.constraint.MotorJoint;
import zpp_nape.phys.Interactor;
import zpp_nape.phys.FeatureMix;
import zpp_nape.phys.Material;
import zpp_nape.constraint.PulleyJoint;
import zpp_nape.phys.FluidProperties;
import zpp_nape.phys.Compound;
import zpp_nape.callbacks.OptionType;
import zpp_nape.phys.Body;
import zpp_nape.callbacks.CbSetPair;
import zpp_nape.callbacks.CbType;
import zpp_nape.callbacks.Callback;
import zpp_nape.callbacks.CbSet;
import zpp_nape.callbacks.Listener;
import zpp_nape.geom.GeomPoly;
import zpp_nape.geom.Mat23;
import zpp_nape.geom.ConvexRayResult;
import zpp_nape.geom.Cutter;
import zpp_nape.geom.Ray;
import zpp_nape.geom.Vec2;
import zpp_nape.geom.Convex;
import zpp_nape.geom.MatMath;
import zpp_nape.geom.PartitionedPoly;
import zpp_nape.geom.Simplify;
import zpp_nape.geom.Triangular;
import zpp_nape.geom.AABB;
import zpp_nape.geom.Simple;
import zpp_nape.geom.SweepDistance;
import zpp_nape.geom.Monotone;
import zpp_nape.geom.VecMath;
import zpp_nape.geom.Vec3;
import zpp_nape.geom.MatMN;
import zpp_nape.geom.PolyIter;
import zpp_nape.geom.MarchingSquares;
import zpp_nape.geom.Geom;
import zpp_nape.shape.Circle;
import zpp_nape.geom.Collide;
import zpp_nape.shape.Shape;
import zpp_nape.shape.Edge;
import zpp_nape.space.Broadphase;
import zpp_nape.shape.Polygon;
import zpp_nape.space.SweepPhase;
import zpp_nape.space.DynAABBPhase;
import zpp_nape.dynamics.Contact;
import zpp_nape.space.Space;
import zpp_nape.dynamics.Arbiter;
import zpp_nape.dynamics.InteractionGroup;
import zpp_nape.dynamics.InteractionFilter;
import zpp_nape.dynamics.SpaceArbiterList;
import zpp_nape.util.Array2;
import zpp_nape.util.Lists;
import zpp_nape.util.Flags;
import zpp_nape.util.Queue;
import zpp_nape.util.Debug;
import zpp_nape.util.FastHash;
import zpp_nape.util.RBTree;
import zpp_nape.util.Pool;
import zpp_nape.util.Names;
import zpp_nape.util.Circular;
import zpp_nape.util.WrapLists;
import zpp_nape.util.Math;
import zpp_nape.util.UserData;
import nape.TArray;
import zpp_nape.util.DisjointSetForest;
import nape.Config;
import nape.constraint.PivotJoint;
import nape.constraint.WeldJoint;
import nape.constraint.Constraint;
import nape.constraint.UserConstraint;
import nape.constraint.DistanceJoint;
import nape.constraint.LineJoint;
import nape.constraint.LinearJoint;
import nape.constraint.ConstraintList;
import nape.constraint.AngleJoint;
import nape.constraint.MotorJoint;
import nape.constraint.ConstraintIterator;
import nape.phys.GravMassMode;
import nape.phys.BodyList;
import nape.phys.Interactor;
import nape.phys.InertiaMode;
import nape.phys.InteractorList;
import nape.constraint.PulleyJoint;
import nape.phys.MassMode;
import nape.phys.Material;
import nape.phys.InteractorIterator;
import nape.phys.FluidProperties;
import nape.phys.BodyIterator;
import nape.phys.Compound;
import nape.phys.CompoundList;
import nape.phys.BodyType;
import nape.phys.CompoundIterator;
import nape.callbacks.InteractionListener;
import nape.callbacks.OptionType;
import nape.callbacks.PreListener;
import nape.callbacks.BodyListener;
import nape.callbacks.ListenerIterator;
import nape.callbacks.CbType;
import nape.callbacks.ListenerType;
import nape.callbacks.PreFlag;
import nape.callbacks.CbEvent;
import nape.callbacks.InteractionType;
import nape.callbacks.PreCallback;
import nape.callbacks.InteractionCallback;
import nape.callbacks.ListenerList;
import nape.callbacks.ConstraintListener;
import nape.phys.Body;
import nape.callbacks.BodyCallback;
import nape.callbacks.CbTypeList;
import nape.callbacks.CbTypeIterator;
import nape.callbacks.Callback;
import nape.callbacks.ConstraintCallback;
import nape.callbacks.Listener;
import nape.geom.Mat23;
import nape.geom.ConvexResultIterator;
import nape.geom.GeomPoly;
import nape.geom.Ray;
import nape.geom.GeomPolyIterator;
import nape.geom.Vec2Iterator;
import nape.geom.RayResult;
import nape.geom.Winding;
import nape.geom.Vec2List;
import nape.geom.RayResultIterator;
import nape.geom.AABB;
import nape.geom.IsoFunction;
import nape.geom.GeomVertexIterator;
import nape.geom.GeomPolyList;
import nape.geom.Vec2;
import nape.geom.RayResultList;
import nape.geom.Vec3;
import nape.geom.MatMN;
import nape.geom.ConvexResultList;
import nape.geom.MarchingSquares;
import nape.shape.Circle;
import nape.geom.Geom;
import nape.shape.ValidationResult;
import nape.shape.ShapeIterator;
import nape.shape.Polygon;
import nape.shape.Edge;
import nape.shape.Shape;
import nape.shape.EdgeList;
import nape.shape.EdgeIterator;
import nape.shape.ShapeList;
import nape.shape.ShapeType;
import nape.space.Broadphase;
import nape.dynamics.Contact;
import nape.dynamics.InteractionGroupList;
import nape.dynamics.Arbiter;
import nape.dynamics.InteractionGroup;
import nape.space.Space;
import nape.dynamics.ContactIterator;
import nape.dynamics.ArbiterList;
import nape.dynamics.InteractionFilter;
import nape.dynamics.ArbiterIterator;
import nape.dynamics.InteractionGroupIterator;
import nape.dynamics.FluidArbiter;
import nape.dynamics.ContactList;
import nape.dynamics.ArbiterType;
import nape.dynamics.CollisionArbiter;
import nape.util.Debug;
import nape.util.BitmapDebug;
import nape.util.ShapeDebug;
/**
 * Class representing the results of a convex cast operation.
 * <br/><br/>
 * These objects are allocated from an object pool and can
 * be released back to that pool by calling its dispose method.
 */
@:final#if nape_swc@:keep #end
class ConvexResult{
    /**
     * @private
     */
    public var zpp_inner:ZPP_ConvexRayResult=null;
    /**
     * The normal of the surface at collision.
     */
    #if nape_swc@:isVar #end
    public var normal(get_normal,never):Vec2;
    inline function get_normal():Vec2{
        #if(!NAPE_RELEASE_BUILD)
        zpp_inner.disposed();
        #end
        return zpp_inner.normal;
    }
    /**
     * The position of the collision.
     */
    #if nape_swc@:isVar #end
    public var position(get_position,never):Vec2;
    inline function get_position():Vec2{
        #if(!NAPE_RELEASE_BUILD)
        zpp_inner.disposed();
        #end
        return zpp_inner.position;
    }
    /**
     * The time of impact to the collision
     */
    #if nape_swc@:isVar #end
    public var toi(get_toi,never):Float;
    inline function get_toi():Float{
        #if(!NAPE_RELEASE_BUILD)
        zpp_inner.disposed();
        #end
        return zpp_inner.toiDistance;
    }
    /**
     * The shape which was collided against.
     */
    #if nape_swc@:isVar #end
    public var shape(get_shape,never):Shape;
    inline function get_shape():Shape{
        #if(!NAPE_RELEASE_BUILD)
        zpp_inner.disposed();
        #end
        return zpp_inner.shape;
    }
    /**
     * @private
     */
    #if flib@:keep function flibopts_0(){}
    #end
    public function new(){
        #if(!NAPE_RELEASE_BUILD)
        if(!ZPP_ConvexRayResult.internal)throw "Error: ConvexResult cannot be instantiated derp!";
        #end
    }
    /**
     * Release ConvexResult object to pool.
     */
    public#if NAPE_NO_INLINE#else inline #end
    function dispose(){
        #if(!NAPE_RELEASE_BUILD)
        zpp_inner.disposed();
        #end
        zpp_inner.free();
    }
    /**
     * @private
     */
    @:keep public function toString(){
        #if(!NAPE_RELEASE_BUILD)
        zpp_inner.disposed();
        #end
        return "{ shape: "+shape+" toi: "+toi+" }";
    }
}
