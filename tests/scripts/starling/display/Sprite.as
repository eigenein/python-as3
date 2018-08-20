package starling.display
{
   import flash.geom.Matrix;
   import flash.geom.Matrix3D;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import starling.core.RenderSupport;
   import starling.utils.MatrixUtil;
   import starling.utils.RectangleUtil;
   
   [Event(name="flatten",type="starling.events.Event")]
   public class Sprite extends DisplayObjectContainer
   {
      
      private static var sHelperMatrix:Matrix = new Matrix();
      
      private static var sHelperPoint:Point = new Point();
      
      private static var sHelperRect:Rectangle = new Rectangle();
       
      
      private var mFlattenedContents:Vector.<QuadBatch>;
      
      private var mFlattenRequested:Boolean;
      
      private var mFlattenOptimized:Boolean;
      
      private var mClipRect:Rectangle;
      
      public function Sprite()
      {
         super();
      }
      
      override public function dispose() : void
      {
         disposeFlattenedContents();
         super.dispose();
      }
      
      private function disposeFlattenedContents() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         if(mFlattenedContents)
         {
            _loc2_ = 0;
            _loc1_ = mFlattenedContents.length;
            while(_loc2_ < _loc1_)
            {
               mFlattenedContents[_loc2_].dispose();
               _loc2_++;
            }
            mFlattenedContents = null;
         }
      }
      
      public function flatten(param1:Boolean = false) : void
      {
         mFlattenRequested = true;
         mFlattenOptimized = param1;
         broadcastEventWith("flatten");
      }
      
      public function unflatten() : void
      {
         mFlattenRequested = false;
         disposeFlattenedContents();
      }
      
      public function get isFlattened() : Boolean
      {
         return mFlattenedContents != null || mFlattenRequested;
      }
      
      public function get clipRect() : Rectangle
      {
         return mClipRect;
      }
      
      public function set clipRect(param1:Rectangle) : void
      {
         if(mClipRect && param1)
         {
            mClipRect.copyFrom(param1);
         }
         else
         {
            mClipRect = !!param1?param1.clone():null;
         }
      }
      
      public function getClipRect(param1:DisplayObject, param2:Rectangle = null) : Rectangle
      {
         var _loc10_:int = 0;
         var _loc3_:* = null;
         if(mClipRect == null)
         {
            return null;
         }
         if(param2 == null)
         {
            param2 = new Rectangle();
         }
         var _loc8_:* = 0;
         var _loc9_:* = 0;
         var _loc5_:* = 1.79769313486232e308;
         var _loc7_:* = -1.79769313486232e308;
         var _loc4_:* = 1.79769313486232e308;
         var _loc6_:* = -1.79769313486232e308;
         var _loc11_:Matrix = getTransformationMatrix(param1,sHelperMatrix);
         _loc10_ = 0;
         while(_loc10_ < 4)
         {
            switch(int(_loc10_))
            {
               case 0:
                  _loc8_ = Number(mClipRect.left);
                  _loc9_ = Number(mClipRect.top);
                  break;
               case 1:
                  _loc8_ = Number(mClipRect.left);
                  _loc9_ = Number(mClipRect.bottom);
                  break;
               case 2:
                  _loc8_ = Number(mClipRect.right);
                  _loc9_ = Number(mClipRect.top);
                  break;
               case 3:
                  _loc8_ = Number(mClipRect.right);
                  _loc9_ = Number(mClipRect.bottom);
            }
            _loc3_ = MatrixUtil.transformCoords(_loc11_,_loc8_,_loc9_,sHelperPoint);
            if(_loc5_ > _loc3_.x)
            {
               _loc5_ = Number(_loc3_.x);
            }
            if(_loc7_ < _loc3_.x)
            {
               _loc7_ = Number(_loc3_.x);
            }
            if(_loc4_ > _loc3_.y)
            {
               _loc4_ = Number(_loc3_.y);
            }
            if(_loc6_ < _loc3_.y)
            {
               _loc6_ = Number(_loc3_.y);
            }
            _loc10_++;
         }
         param2.setTo(_loc5_,_loc4_,_loc7_ - _loc5_,_loc6_ - _loc4_);
         return param2;
      }
      
      override public function getBounds(param1:DisplayObject, param2:Rectangle = null) : Rectangle
      {
         var _loc3_:Rectangle = super.getBounds(param1,param2);
         if(mClipRect)
         {
            RectangleUtil.intersect(_loc3_,getClipRect(param1,sHelperRect),_loc3_);
         }
         return _loc3_;
      }
      
      override public function hitTest(param1:Point, param2:Boolean = false) : DisplayObject
      {
         if(mClipRect != null && !mClipRect.containsPoint(param1))
         {
            return null;
         }
         return super.hitTest(param1,param2);
      }
      
      override public function render(param1:RenderSupport, param2:Number) : void
      {
         var _loc5_:* = null;
         var _loc6_:Number = NaN;
         var _loc8_:int = 0;
         var _loc3_:* = null;
         var _loc7_:int = 0;
         var _loc9_:* = null;
         var _loc4_:* = null;
         if(mClipRect)
         {
            _loc5_ = param1.pushClipRect(getClipRect(stage,sHelperRect));
            if(_loc5_.isEmpty())
            {
               param1.popClipRect();
               return;
            }
         }
         if(mFlattenedContents || mFlattenRequested)
         {
            if(mFlattenedContents == null)
            {
               mFlattenedContents = new Vector.<QuadBatch>(0);
            }
            if(mFlattenRequested)
            {
               QuadBatch.compile(this,mFlattenedContents);
               if(mFlattenOptimized)
               {
                  QuadBatch.optimize(mFlattenedContents);
               }
               param1.applyClipRect();
               mFlattenRequested = false;
            }
            _loc6_ = param2 * this.alpha;
            _loc8_ = mFlattenedContents.length;
            _loc3_ = param1.mvpMatrix3D;
            param1.finishQuadBatch();
            param1.raiseDrawCount(_loc8_);
            _loc7_ = 0;
            while(_loc7_ < _loc8_)
            {
               _loc9_ = mFlattenedContents[_loc7_];
               _loc4_ = _loc9_.blendMode == "auto"?param1.blendMode:_loc9_.blendMode;
               _loc9_.renderCustom(_loc3_,_loc6_,_loc4_);
               _loc7_++;
            }
         }
         else
         {
            super.render(param1,param2);
         }
         if(mClipRect)
         {
            param1.popClipRect();
         }
      }
   }
}
