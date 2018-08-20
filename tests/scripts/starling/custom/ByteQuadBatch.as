package starling.custom
{
   import flash.display3D.Context3D;
   import flash.display3D.Program3D;
   import flash.geom.Matrix;
   import flash.geom.Matrix3D;
   import flash.utils.Dictionary;
   import starling.core.RenderSupport;
   import starling.core.Starling;
   import starling.display.DisplayObject;
   import starling.textures.Texture;
   
   public class ByteQuadBatch extends DisplayObject
   {
      
      public static const MAX_NUM_QUADS:int = 14000;
      
      private static const QUAD_PROGRAM_NAME:String = "CQB_q";
      
      private static var sProgramNameCache:Dictionary = new Dictionary();
      
      private static var sRenderAlpha:Vector.<Number> = new <Number>[1,1,1,1];
       
      
      private var mNumQuads:int;
      
      private var mBatchable:Boolean;
      
      private var mTinted:Boolean;
      
      private var mTexture:Texture;
      
      private var mSmoothing:String;
      
      private var _premultipliedAlpha:Boolean;
      
      private const buffers:ByteQuadBatchBuffers = new ByteQuadBatchBuffers();
      
      public function ByteQuadBatch()
      {
         super();
         mNumQuads = 0;
         mTinted = false;
         mBatchable = false;
      }
      
      private static function getImageProgramName(param1:Boolean, param2:Boolean = true, param3:Boolean = false, param4:String = "bgra", param5:String = "bilinear") : String
      {
         var _loc6_:uint = 0;
         if(param1)
         {
            _loc6_ = _loc6_ | 1;
         }
         if(param2)
         {
            _loc6_ = _loc6_ | 2;
         }
         if(param3)
         {
            _loc6_ = _loc6_ | 4;
         }
         if(param5 == "none")
         {
            _loc6_ = _loc6_ | 8;
         }
         else if(param5 == "trilinear")
         {
            _loc6_ = _loc6_ | 16;
         }
         if(param4 == "compressed")
         {
            _loc6_ = _loc6_ | 32;
         }
         else if(param4 == "compressedAlpha")
         {
            _loc6_ = _loc6_ | 64;
         }
         var _loc7_:String = sProgramNameCache[_loc6_];
         if(_loc7_ == null)
         {
            _loc7_ = "CQB_i." + _loc6_.toString(16);
            sProgramNameCache[_loc6_] = _loc7_;
         }
         return _loc7_;
      }
      
      override public function dispose() : void
      {
         mNumQuads = 0;
         buffers.dispose();
         super.dispose();
      }
      
      public function get numQuads() : int
      {
         return mNumQuads;
      }
      
      public function reset() : void
      {
         mNumQuads = 0;
         mTexture = null;
         mSmoothing = null;
         buffers.vertexBytes.p = 0;
      }
      
      public function addImage(param1:Image, param2:Number = 1.0, param3:Matrix = null, param4:String = null) : void
      {
         addQuad(param1,param2,param1.texture,param1.smoothing,param3,param4);
      }
      
      public function addQuad(param1:ByteQuad, param2:Number = 1.0, param3:Texture = null, param4:String = null, param5:Matrix = null, param6:String = null) : void
      {
         if(param5 == null)
         {
            param5 = param1.transformationMatrix;
         }
         var _loc7_:Number = param2 * param1.alpha;
         buffers.requestCapacity(mNumQuads + 1);
         if(mNumQuads == 0)
         {
            this.blendMode = !!param6?param6:param1.blendMode;
            mTexture = param3;
            mTinted = true;
            mSmoothing = param4;
            _premultipliedAlpha = param1.premultipliedAlpha;
         }
         param1.copyVertexDataTransformedTo(buffers.vertexBytes,mNumQuads,param5,_loc7_,!!param6?param6:param1.blendMode);
         mNumQuads = Number(mNumQuads) + 1;
      }
      
      public function isStateChange(param1:Boolean, param2:Number, param3:Texture, param4:String, param5:String, param6:int = 1) : Boolean
      {
         var _loc8_:Boolean = false;
         var _loc7_:Boolean = false;
         if(mNumQuads == 0)
         {
            return false;
         }
         if(mNumQuads + param6 > 14000)
         {
            return true;
         }
         if(mTexture == null && param3 == null)
         {
            if(this.blendMode == param5)
            {
               return false;
            }
            if(_premultipliedAlpha)
            {
               _loc8_ = this.blendMode == "normal" || this.blendMode == "add" || this.blendMode == "auto" || this.blendMode == "none";
               _loc7_ = param5 == "normal" || param5 == "add" || param5 == "auto" || param5 == "none";
               return !(_loc8_ && _loc7_);
            }
            return true;
         }
         if(mTexture != null && param3 != null)
         {
            if(mTexture.base != param3.base || mTexture.repeat != param3.repeat || mSmoothing != param4 || mTinted != (param1 || param2 != 1))
            {
               return true;
            }
            if(this.blendMode == param5)
            {
               return false;
            }
            if(_premultipliedAlpha)
            {
               _loc8_ = this.blendMode == "normal" || this.blendMode == "add" || this.blendMode == "auto" || this.blendMode == "none";
               _loc7_ = param5 == "normal" || param5 == "add" || param5 == "auto" || param5 == "none";
               return !(_loc8_ && _loc7_);
            }
            return true;
         }
         return true;
      }
      
      public function renderCustom(param1:Matrix3D, param2:Number = 1.0, param3:String = null) : void
      {
         if(mNumQuads == 0)
         {
            return;
         }
         buffers.sync();
         var _loc4_:Boolean = _premultipliedAlpha;
         var _loc6_:Context3D = Starling.context;
         var _loc5_:Boolean = mTinted || param2 != 1;
         var _loc7_:* = !!_loc4_?param2:1;
         sRenderAlpha[2] = _loc7_;
         _loc7_ = _loc7_;
         sRenderAlpha[1] = _loc7_;
         sRenderAlpha[0] = _loc7_;
         sRenderAlpha[3] = param2;
         if(param3 == null)
         {
            param3 = this.blendMode;
         }
         if(param3 == "add")
         {
            param3 = "normal";
         }
         RenderSupport.setBlendFactors(_loc4_,param3);
         _loc6_.setProgram(getProgram(_loc5_));
         _loc6_.setProgramConstantsFromVector("vertex",0,sRenderAlpha,1);
         _loc6_.setProgramConstantsFromMatrix("vertex",1,param1,true);
         _loc6_.setVertexBufferAt(0,buffers.vertexBuffer,0,"float2");
         if(mTexture == null || _loc5_)
         {
            _loc6_.setVertexBufferAt(1,buffers.vertexBuffer,2,"bytes4");
         }
         if(mTexture)
         {
            _loc6_.setTextureAt(0,mTexture.base);
            _loc6_.setVertexBufferAt(2,buffers.vertexBuffer,3,"float2");
         }
         _loc6_.drawTriangles(buffers.indexBuffer,0,mNumQuads * 2);
         if(mTexture)
         {
            _loc6_.setTextureAt(0,null);
            _loc6_.setVertexBufferAt(2,null);
         }
         _loc6_.setVertexBufferAt(1,null);
         _loc6_.setVertexBufferAt(0,null);
      }
      
      private function getProgram(param1:Boolean) : Program3D
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc6_:Starling = Starling.current;
         var _loc2_:String = "CQB_q";
         if(mTexture)
         {
            _loc2_ = getImageProgramName(param1,mTexture.mipMapping,mTexture.repeat,mTexture.format,mSmoothing);
         }
         var _loc5_:Program3D = _loc6_.getProgram(_loc2_);
         if(!_loc5_)
         {
            if(!mTexture)
            {
               _loc3_ = "m44 op, va0, vc1 \nmul v0, va1, vc0 \n";
               _loc4_ = "mov oc, v0       \n";
            }
            else
            {
               _loc3_ = !!param1?"m44 op, va0, vc1 \nmul v0, va1, vc0 \nmov v1, va2      \n":"m44 op, va0, vc1 \nmov v1, va2      \n";
               _loc4_ = !!param1?"tex ft1,  v1, fs0 <???> \nmul  oc, ft1,  v0       \n":"tex  oc,  v1, fs0 <???> \n";
               _loc4_ = _loc4_.replace("<???>",RenderSupport.getTextureLookupFlags(mTexture.format,mTexture.mipMapping,mTexture.repeat,mSmoothing));
            }
            _loc5_ = _loc6_.registerProgramFromSource(_loc2_,_loc3_,_loc4_);
         }
         return _loc5_;
      }
   }
}
