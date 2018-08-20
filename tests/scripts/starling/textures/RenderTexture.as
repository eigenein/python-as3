package starling.textures
{
   import flash.display3D.Context3D;
   import flash.display3D.VertexBuffer3D;
   import flash.display3D.textures.TextureBase;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import starling.core.RenderSupport;
   import starling.core.Starling;
   import starling.display.DisplayObject;
   import starling.display.Image;
   import starling.errors.MissingContextError;
   import starling.filters.FragmentFilter;
   import starling.utils.SystemUtil;
   import starling.utils.execute;
   import starling.utils.getNextPowerOfTwo;
   
   public class RenderTexture extends SubTexture
   {
      
      private static var sClipRect:Rectangle = new Rectangle();
      
      public static var optimizePersistentBuffers:Boolean = false;
       
      
      private const CONTEXT_POT_SUPPORT_KEY:String = "RenderTexture.supportsNonPotDimensions";
      
      private const PMA:Boolean = true;
      
      private var mActiveTexture:Texture;
      
      private var mBufferTexture:Texture;
      
      private var mHelperImage:Image;
      
      private var mDrawing:Boolean;
      
      private var mBufferReady:Boolean;
      
      private var mIsPersistent:Boolean;
      
      private var mSupport:RenderSupport;
      
      public function RenderTexture(param1:int, param2:int, param3:Boolean = true, param4:Number = -1, param5:String = "bgra", param6:Boolean = false)
      {
         if(param4 <= 0)
         {
            param4 = Starling.contentScaleFactor;
         }
         var _loc8_:Number = param1;
         var _loc10_:Number = param2;
         if(!supportsNonPotDimensions)
         {
            _loc8_ = getNextPowerOfTwo(param1 * param4) / param4;
            _loc10_ = getNextPowerOfTwo(param2 * param4) / param4;
         }
         mActiveTexture = Texture.empty(_loc8_,_loc10_,true,false,true,param4,param5,param6);
         mActiveTexture.root.onRestore = mActiveTexture.root.clear;
         TextureMemoryManager.add(mActiveTexture,"RenderTexture active" + _loc8_ + "x" + _loc10_);
         super(mActiveTexture,new Rectangle(0,0,param1,param2),true,null,false);
         var _loc7_:Number = mActiveTexture.root.width;
         var _loc9_:Number = mActiveTexture.root.height;
         mIsPersistent = param3;
         mSupport = new RenderSupport();
         mSupport.setProjectionMatrix(0,0,_loc7_,_loc9_,param1,param2);
         if(param3 && (!optimizePersistentBuffers || !SystemUtil.supportsRelaxedTargetClearRequirement))
         {
            mBufferTexture = Texture.empty(_loc8_,_loc10_,true,false,true,param4,param5,param6);
            TextureMemoryManager.add(mBufferTexture,"RenderTexture buffer" + _loc8_ + "x" + _loc10_);
            mBufferTexture.root.onRestore = mBufferTexture.root.clear;
            mHelperImage = new Image(mBufferTexture);
            mHelperImage.smoothing = "none";
         }
      }
      
      override public function dispose() : void
      {
         mSupport.dispose();
         if(parent != mActiveTexture)
         {
            mActiveTexture.dispose();
         }
         if(isDoubleBuffered)
         {
            if(parent != mBufferTexture)
            {
               mBufferTexture.dispose();
            }
            mHelperImage.dispose();
         }
         super.dispose();
      }
      
      public function draw(param1:DisplayObject, param2:Matrix = null, param3:Number = 1.0, param4:int = 0) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(mDrawing)
         {
            render(param1,param2,param3);
         }
         else
         {
            renderBundled(render,param1,param2,param3,param4);
         }
      }
      
      public function drawBundled(param1:Function, param2:int = 0) : void
      {
         renderBundled(param1,null,null,1,param2);
      }
      
      private function render(param1:DisplayObject, param2:Matrix = null, param3:Number = 1.0) : void
      {
         var _loc4_:FragmentFilter = param1.filter;
         mSupport.loadIdentity();
         mSupport.blendMode = param1.blendMode == "auto"?"normal":param1.blendMode;
         if(param2)
         {
            mSupport.prependMatrix(param2);
         }
         else
         {
            mSupport.transformMatrix(param1);
         }
         if(_loc4_)
         {
            _loc4_.render(param1,mSupport,param3);
         }
         else
         {
            param1.render(mSupport,param3);
         }
      }
      
      private function renderBundled(param1:Function, param2:DisplayObject = null, param3:Matrix = null, param4:Number = 1.0, param5:int = 0) : void
      {
         var _loc6_:* = null;
         var _loc7_:Context3D = Starling.context;
         if(_loc7_ == null)
         {
            throw new MissingContextError();
         }
         if(!Starling.current.contextValid)
         {
            return;
         }
         if(isDoubleBuffered)
         {
            _loc6_ = mActiveTexture;
            mActiveTexture = mBufferTexture;
            mBufferTexture = _loc6_;
            mHelperImage.texture = mBufferTexture;
         }
         sClipRect.setTo(0,0,mActiveTexture.width,mActiveTexture.height);
         mSupport.pushClipRect(sClipRect);
         mSupport.setRenderTarget(mActiveTexture,param5);
         if(isDoubleBuffered || !isPersistent || !mBufferReady)
         {
            mSupport.clearInstance();
         }
         if(isDoubleBuffered && mBufferReady)
         {
            mHelperImage.render(mSupport,1);
         }
         else
         {
            mBufferReady = true;
         }
         try
         {
            mDrawing = true;
            execute(param1,param2,param3,param4);
         }
         catch(e:*)
         {
         }
         mDrawing = false;
         mSupport.finishQuadBatch();
         mSupport.nextFrame();
         mSupport.renderTarget = null;
         mSupport.popClipRect();
      }
      
      public function clear(param1:uint = 0, param2:Number = 0.0) : void
      {
         var _loc3_:Context3D = Starling.context;
         if(_loc3_ == null)
         {
            throw new MissingContextError();
         }
         if(!Starling.current.contextValid)
         {
            return;
         }
         mSupport.renderTarget = mActiveTexture;
         mSupport.clearInstance(param1,param2);
         mSupport.renderTarget = null;
         mBufferReady = true;
      }
      
      private function get supportsNonPotDimensions() : Boolean
      {
         var _loc1_:* = null;
         var _loc3_:* = null;
         var _loc5_:Starling = Starling.current;
         var _loc2_:Context3D = Starling.context;
         var _loc4_:Object = _loc5_.contextData["RenderTexture.supportsNonPotDimensions"];
         if(_loc4_ == null)
         {
            if(_loc5_.profile != "baselineConstrained" && "createRectangleTexture" in _loc2_)
            {
               _loc1_ = null;
               _loc3_ = null;
               try
               {
                  _loc1_ = _loc2_["createRectangleTexture"](2,3,"bgra",true);
                  _loc2_.setRenderToTexture(_loc1_);
                  _loc2_.clear();
                  _loc2_.setRenderToBackBuffer();
                  _loc3_ = _loc2_.createVertexBuffer(1,1);
                  _loc4_ = true;
               }
               catch(e:Error)
               {
                  _loc4_ = false;
                  if(_loc1_)
                  {
                     _loc1_.dispose();
                  }
                  if(_loc3_)
                  {
                     _loc3_.dispose();
                  }
               }
            }
            else
            {
               _loc4_ = false;
            }
            _loc5_.contextData["RenderTexture.supportsNonPotDimensions"] = _loc4_;
         }
         return _loc4_;
      }
      
      private function get isDoubleBuffered() : Boolean
      {
         return mBufferTexture != null;
      }
      
      public function get isPersistent() : Boolean
      {
         return mIsPersistent;
      }
      
      override public function get base() : TextureBase
      {
         return mActiveTexture.base;
      }
      
      override public function get root() : ConcreteTexture
      {
         return mActiveTexture.root;
      }
   }
}
