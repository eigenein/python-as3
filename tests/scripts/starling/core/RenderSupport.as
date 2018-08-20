package starling.core
{
   import com.adobe.utils.AGALMiniAssembler;
   import flash.display3D.Context3D;
   import flash.display3D.Program3D;
   import flash.geom.Matrix;
   import flash.geom.Matrix3D;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.geom.Vector3D;
   import starling.custom.ByteQuad;
   import starling.custom.ByteQuadBatch;
   import starling.display.BlendMode;
   import starling.display.DisplayObject;
   import starling.display.Quad;
   import starling.display.QuadBatch;
   import starling.display.Stage;
   import starling.errors.MissingContextError;
   import starling.textures.Texture;
   import starling.utils.Color;
   import starling.utils.MatrixUtil;
   import starling.utils.RectangleUtil;
   
   public class RenderSupport
   {
      
      private static var sPoint:Point = new Point();
      
      private static var sPoint3D:Vector3D = new Vector3D();
      
      private static var sClipRect:Rectangle = new Rectangle();
      
      private static var sBufferRect:Rectangle = new Rectangle();
      
      private static var sScissorRect:Rectangle = new Rectangle();
      
      private static var sAssembler:AGALMiniAssembler = new AGALMiniAssembler();
      
      private static var sMatrix3D:Matrix3D = new Matrix3D();
      
      private static var sMatrixData:Vector.<Number> = new <Number>[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
       
      
      private var mProjectionMatrix:Matrix;
      
      private var mModelViewMatrix:Matrix;
      
      private var mMvpMatrix:Matrix;
      
      private var mMatrixStack:Vector.<Matrix>;
      
      private var mMatrixStackSize:int;
      
      private var mProjectionMatrix3D:Matrix3D;
      
      private var mModelViewMatrix3D:Matrix3D;
      
      private var mMvpMatrix3D:Matrix3D;
      
      private var mMatrixStack3D:Vector.<Matrix3D>;
      
      private var mMatrixStack3DSize:int;
      
      private var mDrawCount:int;
      
      private var mBlendMode:String;
      
      private var mRenderTarget:Texture;
      
      private var mClipRectStack:Vector.<Rectangle>;
      
      private var mClipRectStackSize:int;
      
      private var mQuadBatches:Vector.<QuadBatch>;
      
      private var mCurrentQuadBatchID:int;
      
      private var mByteQuadBatch:ByteQuadBatch;
      
      public function RenderSupport()
      {
         super();
         mProjectionMatrix = new Matrix();
         mModelViewMatrix = new Matrix();
         mMvpMatrix = new Matrix();
         mMatrixStack = new Vector.<Matrix>(0);
         mMatrixStackSize = 0;
         mProjectionMatrix3D = new Matrix3D();
         mModelViewMatrix3D = new Matrix3D();
         mMvpMatrix3D = new Matrix3D();
         mMatrixStack3D = new Vector.<Matrix3D>(0);
         mMatrixStack3DSize = 0;
         mDrawCount = 0;
         mRenderTarget = null;
         mBlendMode = "normal";
         mClipRectStack = new Vector.<Rectangle>(0);
         mCurrentQuadBatchID = 0;
         mQuadBatches = new <QuadBatch>[new QuadBatch()];
         mByteQuadBatch = new ByteQuadBatch();
         loadIdentity();
         setProjectionMatrix(0,0,400,300);
      }
      
      public static function transformMatrixForObject(param1:Matrix, param2:DisplayObject) : void
      {
         MatrixUtil.prependMatrix(param1,param2.transformationMatrix);
      }
      
      public static function setDefaultBlendFactors(param1:Boolean) : void
      {
         setBlendFactors(param1);
      }
      
      public static function setBlendFactors(param1:Boolean, param2:String = "normal") : void
      {
         var _loc3_:Array = BlendMode.getBlendFactors(param2,param1);
         Starling.context.setBlendFactors(_loc3_[0],_loc3_[1]);
      }
      
      public static function clear(param1:uint = 0, param2:Number = 0.0) : void
      {
         Starling.context.clear(Color.getRed(param1) / 255,Color.getGreen(param1) / 255,Color.getBlue(param1) / 255,param2);
      }
      
      public static function assembleAgal(param1:String, param2:String, param3:Program3D = null) : Program3D
      {
         var _loc4_:* = null;
         if(param3 == null)
         {
            _loc4_ = Starling.context;
            if(_loc4_ == null)
            {
               throw new MissingContextError();
            }
            param3 = _loc4_.createProgram();
         }
         param3.upload(sAssembler.assemble("vertex",param1),sAssembler.assemble("fragment",param2));
         return param3;
      }
      
      public static function getTextureLookupFlags(param1:String, param2:Boolean, param3:Boolean = false, param4:String = "bilinear") : String
      {
         var _loc5_:Array = ["2d",!!param3?"repeat":"clamp"];
         if(param1 == "compressed")
         {
            _loc5_.push("dxt1");
         }
         else if(param1 == "compressedAlpha")
         {
            _loc5_.push("dxt5");
         }
         if(param4 == "none")
         {
            _loc5_.push("nearest",!!param2?"mipnearest":"mipnone");
         }
         else if(param4 == "bilinear")
         {
            _loc5_.push("linear",!!param2?"mipnearest":"mipnone");
         }
         else
         {
            _loc5_.push("linear",!!param2?"miplinear":"mipnone");
         }
         return "<" + _loc5_.join() + ">";
      }
      
      public function dispose() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = mQuadBatches;
         for each(var _loc1_ in mQuadBatches)
         {
            _loc1_.dispose();
         }
         mByteQuadBatch.dispose();
      }
      
      public function setProjectionMatrix(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number = 0, param6:Number = 0, param7:Vector3D = null) : void
      {
         var _loc13_:* = NaN;
         _loc13_ = 1;
         if(param5 <= 0)
         {
            param5 = param3;
         }
         if(param6 <= 0)
         {
            param6 = param4;
         }
         if(param7 == null)
         {
            param7 = sPoint3D;
            param7.setTo(param5 / 2,param6 / 2,param5 / Math.tan(0.5) * 0.5);
         }
         mProjectionMatrix.setTo(2 / param3,0,0,-2 / param4,-(2 * param1 + param3) / param3,(2 * param2 + param4) / param4);
         var _loc14_:Number = Math.abs(param7.z);
         var _loc8_:Number = param7.x - param5 / 2;
         var _loc11_:Number = param7.y - param6 / 2;
         var _loc12_:Number = _loc14_ * 20;
         var _loc9_:Number = param5 / param3;
         var _loc10_:Number = param6 / param4;
         sMatrixData[0] = 2 * _loc14_ / param5;
         sMatrixData[5] = -2 * _loc14_ / param6;
         sMatrixData[10] = _loc12_ / (_loc12_ - 1);
         sMatrixData[14] = -_loc12_ * 1 / (_loc12_ - 1);
         sMatrixData[11] = 1;
         var _loc15_:* = 0;
         var _loc16_:* = sMatrixData[_loc15_] * _loc9_;
         sMatrixData[_loc15_] = _loc16_;
         _loc16_ = 5;
         _loc15_ = sMatrixData[_loc16_] * _loc10_;
         sMatrixData[_loc16_] = _loc15_;
         sMatrixData[8] = _loc9_ - 1 - 2 * _loc9_ * (param1 - _loc8_) / param5;
         sMatrixData[9] = -_loc10_ + 1 + 2 * _loc10_ * (param2 - _loc11_) / param6;
         mProjectionMatrix3D.copyRawDataFrom(sMatrixData);
         mProjectionMatrix3D.prependTranslation(-param5 / 2 - _loc8_,-param6 / 2 - _loc11_,_loc14_);
         applyClipRect();
      }
      
      public function setOrthographicProjection(param1:Number, param2:Number, param3:Number, param4:Number) : void
      {
         var _loc5_:Stage = Starling.current.stage;
         sClipRect.setTo(param1,param2,param3,param4);
         setProjectionMatrix(param1,param2,param3,param4,_loc5_.stageWidth,_loc5_.stageHeight,_loc5_.cameraPosition);
      }
      
      public function loadIdentity() : void
      {
         mModelViewMatrix.identity();
         mModelViewMatrix3D.identity();
      }
      
      public function translateMatrix(param1:Number, param2:Number) : void
      {
         MatrixUtil.prependTranslation(mModelViewMatrix,param1,param2);
      }
      
      public function rotateMatrix(param1:Number) : void
      {
         MatrixUtil.prependRotation(mModelViewMatrix,param1);
      }
      
      public function scaleMatrix(param1:Number, param2:Number) : void
      {
         MatrixUtil.prependScale(mModelViewMatrix,param1,param2);
      }
      
      public function prependMatrix(param1:Matrix) : void
      {
         MatrixUtil.prependMatrix(mModelViewMatrix,param1);
      }
      
      public function transformMatrix(param1:DisplayObject) : void
      {
         MatrixUtil.prependMatrix(mModelViewMatrix,param1.transformationMatrix);
      }
      
      public function pushMatrix() : void
      {
         if(mMatrixStack.length < mMatrixStackSize + 1)
         {
            mMatrixStack.push(new Matrix());
         }
         mMatrixStackSize = Number(mMatrixStackSize) + 1;
         mMatrixStack[int(Number(mMatrixStackSize))].copyFrom(mModelViewMatrix);
      }
      
      public function popMatrix() : void
      {
         mMatrixStackSize = mMatrixStackSize - 1;
         mModelViewMatrix.copyFrom(mMatrixStack[int(mMatrixStackSize - 1)]);
      }
      
      public function resetMatrix() : void
      {
         mMatrixStackSize = 0;
         mMatrixStack3DSize = 0;
         loadIdentity();
      }
      
      public function get mvpMatrix() : Matrix
      {
         mMvpMatrix.copyFrom(mModelViewMatrix);
         mMvpMatrix.concat(mProjectionMatrix);
         return mMvpMatrix;
      }
      
      public function get modelViewMatrix() : Matrix
      {
         return mModelViewMatrix;
      }
      
      public function get projectionMatrix() : Matrix
      {
         return mProjectionMatrix;
      }
      
      public function set projectionMatrix(param1:Matrix) : void
      {
         mProjectionMatrix.copyFrom(param1);
         applyClipRect();
      }
      
      public function transformMatrix3D(param1:DisplayObject) : void
      {
         mModelViewMatrix3D.prepend(MatrixUtil.convertTo3D(mModelViewMatrix,sMatrix3D));
         mModelViewMatrix3D.prepend(param1.transformationMatrix3D);
         mModelViewMatrix.identity();
      }
      
      public function pushMatrix3D() : void
      {
         if(mMatrixStack3D.length < mMatrixStack3DSize + 1)
         {
            mMatrixStack3D.push(new Matrix3D());
         }
         mMatrixStack3DSize = Number(mMatrixStack3DSize) + 1;
         mMatrixStack3D[int(Number(mMatrixStack3DSize))].copyFrom(mModelViewMatrix3D);
      }
      
      public function popMatrix3D() : void
      {
         mMatrixStack3DSize = mMatrixStack3DSize - 1;
         mModelViewMatrix3D.copyFrom(mMatrixStack3D[int(mMatrixStack3DSize - 1)]);
      }
      
      public function get mvpMatrix3D() : Matrix3D
      {
         if(mMatrixStack3DSize == 0)
         {
            MatrixUtil.convertTo3D(mvpMatrix,mMvpMatrix3D);
         }
         else
         {
            mMvpMatrix3D.copyFrom(mProjectionMatrix3D);
            mMvpMatrix3D.prepend(mModelViewMatrix3D);
            mMvpMatrix3D.prepend(MatrixUtil.convertTo3D(mModelViewMatrix,sMatrix3D));
         }
         return mMvpMatrix3D;
      }
      
      public function get projectionMatrix3D() : Matrix3D
      {
         return mProjectionMatrix3D;
      }
      
      public function set projectionMatrix3D(param1:Matrix3D) : void
      {
         mProjectionMatrix3D.copyFrom(param1);
      }
      
      public function applyBlendMode(param1:Boolean) : void
      {
         setBlendFactors(param1,mBlendMode);
      }
      
      public function get blendMode() : String
      {
         return mBlendMode;
      }
      
      public function set blendMode(param1:String) : void
      {
         if(param1 != "auto")
         {
            mBlendMode = param1;
         }
      }
      
      public function get renderTarget() : Texture
      {
         return mRenderTarget;
      }
      
      public function set renderTarget(param1:Texture) : void
      {
         setRenderTarget(param1);
      }
      
      public function setRenderTarget(param1:Texture, param2:int = 0) : void
      {
         mRenderTarget = param1;
         applyClipRect();
         if(param1)
         {
            Starling.context.setRenderToTexture(param1.base,false,param2);
         }
         else
         {
            Starling.context.setRenderToBackBuffer();
         }
      }
      
      public function pushClipRect(param1:Rectangle) : Rectangle
      {
         if(mClipRectStack.length < mClipRectStackSize + 1)
         {
            mClipRectStack.push(new Rectangle());
         }
         mClipRectStack[mClipRectStackSize].copyFrom(param1);
         param1 = mClipRectStack[mClipRectStackSize];
         if(mClipRectStackSize > 0)
         {
            RectangleUtil.intersect(param1,mClipRectStack[mClipRectStackSize - 1],param1);
         }
         mClipRectStackSize = mClipRectStackSize + 1;
         applyClipRect();
         return param1;
      }
      
      public function popClipRect() : void
      {
         if(mClipRectStackSize > 0)
         {
            mClipRectStackSize = mClipRectStackSize - 1;
            applyClipRect();
         }
      }
      
      public function applyClipRect() : void
      {
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc1_:* = null;
         finishQuadBatch();
         finishByteQuadBatch();
         var _loc2_:Context3D = Starling.context;
         if(_loc2_ == null)
         {
            return;
         }
         if(mClipRectStackSize > 0)
         {
            _loc1_ = mClipRectStack[mClipRectStackSize - 1];
            if(mRenderTarget)
            {
               _loc3_ = mRenderTarget.root.nativeWidth;
               _loc4_ = mRenderTarget.root.nativeHeight;
            }
            else
            {
               _loc3_ = Starling.current.backBufferWidth;
               _loc4_ = Starling.current.backBufferHeight;
            }
            MatrixUtil.transformCoords(mProjectionMatrix,_loc1_.x,_loc1_.y,sPoint);
            sClipRect.x = (sPoint.x * 0.5 + 0.5) * _loc3_;
            sClipRect.y = (0.5 - sPoint.y * 0.5) * _loc4_;
            MatrixUtil.transformCoords(mProjectionMatrix,_loc1_.right,_loc1_.bottom,sPoint);
            sClipRect.right = (sPoint.x * 0.5 + 0.5) * _loc3_;
            sClipRect.bottom = (0.5 - sPoint.y * 0.5) * _loc4_;
            sBufferRect.setTo(0,0,_loc3_,_loc4_);
            RectangleUtil.intersect(sClipRect,sBufferRect,sScissorRect);
            if(sScissorRect.width < 1 || sScissorRect.height < 1)
            {
               sScissorRect.setTo(0,0,1,1);
            }
            _loc2_.setScissorRectangle(sScissorRect);
         }
         else
         {
            _loc2_.setScissorRectangle(null);
         }
      }
      
      public function batchQuad(param1:Quad, param2:Number, param3:Texture = null, param4:String = null) : void
      {
         if(mByteQuadBatch.numQuads > 0)
         {
            finishByteQuadBatch();
         }
         if(mQuadBatches[mCurrentQuadBatchID].isStateChange(param1.tinted,param2,param3,param4,mBlendMode))
         {
            finishQuadBatch();
         }
         mQuadBatches[mCurrentQuadBatchID].addQuad(param1,param2,param3,param4,mModelViewMatrix,mBlendMode);
      }
      
      public function batchByteQuad(param1:ByteQuad, param2:Number, param3:Texture = null, param4:String = null) : void
      {
         if(mQuadBatches[mCurrentQuadBatchID].numQuads > 0)
         {
            finishQuadBatch();
         }
         if(mByteQuadBatch.isStateChange(true,param2,param3,param4,mBlendMode))
         {
            finishByteQuadBatch();
         }
         mByteQuadBatch.addQuad(param1,param2,param3,param4,mModelViewMatrix,mBlendMode);
      }
      
      public function batchQuadBatch(param1:QuadBatch, param2:Number) : void
      {
         if(mByteQuadBatch.numQuads > 0)
         {
            finishByteQuadBatch();
         }
         if(mQuadBatches[mCurrentQuadBatchID].isStateChange(param1.tinted,param2,param1.texture,param1.smoothing,mBlendMode,param1.numQuads))
         {
            finishQuadBatch();
         }
         mQuadBatches[mCurrentQuadBatchID].addQuadBatch(param1,param2,mModelViewMatrix,mBlendMode);
      }
      
      public function finishQuadBatch() : void
      {
         if(mByteQuadBatch.numQuads > 0)
         {
            finishByteQuadBatch();
         }
         var _loc1_:QuadBatch = mQuadBatches[mCurrentQuadBatchID];
         if(_loc1_.numQuads != 0)
         {
            if(mMatrixStack3DSize == 0)
            {
               _loc1_.renderCustom(mProjectionMatrix3D);
            }
            else
            {
               mMvpMatrix3D.copyFrom(mProjectionMatrix3D);
               mMvpMatrix3D.prepend(mModelViewMatrix3D);
               _loc1_.renderCustom(mMvpMatrix3D);
            }
            _loc1_.reset();
            mCurrentQuadBatchID = mCurrentQuadBatchID + 1;
            mDrawCount = mDrawCount + 1;
            if(mQuadBatches.length <= mCurrentQuadBatchID)
            {
               mQuadBatches.push(new QuadBatch());
            }
         }
      }
      
      public function finishByteQuadBatch() : void
      {
         var _loc1_:ByteQuadBatch = mByteQuadBatch;
         if(_loc1_.numQuads != 0)
         {
            if(mMatrixStack3DSize == 0)
            {
               _loc1_.renderCustom(mProjectionMatrix3D);
            }
            else
            {
               mMvpMatrix3D.copyFrom(mProjectionMatrix3D);
               mMvpMatrix3D.prepend(mModelViewMatrix3D);
               _loc1_.renderCustom(mMvpMatrix3D);
            }
            _loc1_.reset();
            mDrawCount = mDrawCount + 1;
         }
      }
      
      public function nextFrame() : void
      {
         resetMatrix();
         trimQuadBatches();
         mCurrentQuadBatchID = 0;
         mBlendMode = "normal";
         mDrawCount = 0;
      }
      
      private function trimQuadBatches() : void
      {
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc1_:int = mCurrentQuadBatchID + 1;
         var _loc2_:int = mQuadBatches.length;
         if(_loc2_ >= 16 && _loc2_ > 2 * _loc1_)
         {
            _loc4_ = _loc2_ - _loc1_;
            _loc3_ = 0;
            while(_loc3_ < _loc4_)
            {
               mQuadBatches.pop().dispose();
               _loc3_++;
            }
         }
      }
      
      public function clearInstance(param1:uint = 0, param2:Number = 0.0) : void
      {
         RenderSupport.clear(param1,param2);
      }
      
      public function raiseDrawCount(param1:uint = 1) : void
      {
         mDrawCount = mDrawCount + param1;
      }
      
      public function get drawCount() : int
      {
         return mDrawCount;
      }
   }
}
