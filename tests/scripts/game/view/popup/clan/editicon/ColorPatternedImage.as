package game.view.popup.clan.editicon
{
   import flash.display3D.Context3D;
   import flash.display3D.IndexBuffer3D;
   import flash.display3D.Program3D;
   import flash.display3D.VertexBuffer3D;
   import flash.geom.Rectangle;
   import starling.core.RenderSupport;
   import starling.core.Starling;
   import starling.display.DisplayObject;
   import starling.errors.MissingContextError;
   import starling.textures.Texture;
   
   public class ColorPatternedImage extends DisplayObject
   {
      
      private static const PROGRAM_NAME_NEAREST:String = "drawColoredImageNearest";
      
      private static const PROGRAM_NAME_LINEAR:String = "drawColoredImageLinear";
      
      private static const NUM_VERTICES:Number = 4;
      
      private static const ELEMENTS_PER_VERTEX:Number = 6;
      
      private static const POSITION_OFFSET:int = 0;
      
      private static const UV_OFFSET:int = 2;
       
      
      private var texture:Texture;
      
      private var _colorPattern:Texture;
      
      private var smoothing:String;
      
      private var vertices:Vector.<Number>;
      
      private var indices:Vector.<uint>;
      
      private var colors:Vector.<Number>;
      
      private var _colorUV:Vector.<Number>;
      
      private var _colorUVBuffer:VertexBuffer3D;
      
      private var _colorUVInvalidated:Boolean = false;
      
      private var canvasColors:Vector.<Number>;
      
      private var alphaVectorConsts:Vector.<Number>;
      
      private var _vertexBuffer:VertexBuffer3D;
      
      private var _indexBuffer:IndexBuffer3D;
      
      private var premultipliedAlpha:Boolean;
      
      public function ColorPatternedImage(param1:Texture)
      {
         indices = new <uint>[0,1,2,2,3,0];
         colors = new Vector.<Number>(8,true);
         _colorUV = new Vector.<Number>(8,true);
         canvasColors = new <Number>[1,0,0,0,0.5,0.5,0,0,0,1,0,0,0,0,0,1];
         alphaVectorConsts = new <Number>[0,0,0,1];
         super();
         if(!param1)
         {
            throw new ArgumentError("Texture cannot be null");
         }
         this.texture = param1;
         vertices = new Vector.<Number>(4 * 6,true);
         readjustSize();
         premultipliedAlpha = param1.premultipliedAlpha;
         setTexCoords(1,1);
         param1.adjustTexCoords(vertices,2,6 - 2);
         smoothing = "bilinear";
         Starling.current.stage3D.addEventListener("context3DCreate",handler_contextCreated,false,0,true);
      }
      
      private static function getProgram(param1:Boolean) : Program3D
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc5_:Starling = Starling.current;
         var _loc2_:String = !!param1?"drawColoredImageNearest":"drawColoredImageLinear";
         if(!_loc5_.hasProgram(_loc2_))
         {
            _loc3_ = "m44 op, va0, vc0 \nmov v1, va2 \nmov v0, va1 \n";
            _loc4_ = "tex ft0, v0, fs0 <2d, clamp, " + (!!param1?"nearest":"linear") + ", mipnone> \n" + "tex ft1, v1, fs1 <2d, clamp, " + (!!param1?"nearest":"linear") + ", mipnone>\n" + "m44 ft1, ft1, fc0 \n" + "mul ft0, ft0, ft1 \n" + "mul ft0.a, ft0.a, fc4.w \n" + "mov oc, ft0 \n";
            _loc5_.registerProgramFromSource(_loc2_,_loc3_,_loc4_);
         }
         return _loc5_.getProgram(_loc2_);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         _colorPattern = null;
         if(_vertexBuffer)
         {
            _vertexBuffer.dispose();
            _vertexBuffer = null;
         }
         if(_indexBuffer)
         {
            _indexBuffer.dispose();
            _indexBuffer = null;
         }
         if(_colorUVBuffer)
         {
            _colorUVBuffer.dispose();
            _colorUVBuffer = null;
         }
      }
      
      public function set colorPattern(param1:Texture) : void
      {
         _colorPattern = param1;
         _colorUV = new <Number>[0,0,1,0,1,1,0,1];
         _colorPattern.adjustTexCoords(_colorUV);
         _colorUVInvalidated = true;
      }
      
      public function set color1(param1:uint) : void
      {
         canvasColors[0] = (param1 >>> 16 & 255) / 255;
         canvasColors[4] = (param1 >>> 8 & 255) / 255;
         canvasColors[8] = (param1 & 255) / 255;
      }
      
      public function set color2(param1:uint) : void
      {
         canvasColors[1] = (param1 >>> 16 & 255) / 255;
         canvasColors[5] = (param1 >>> 8 & 255) / 255;
         canvasColors[9] = (param1 & 255) / 255;
      }
      
      override public function getBounds(param1:DisplayObject, param2:Rectangle = null) : Rectangle
      {
         CustomContext3DUtils.getVerticesBounds(vertices,4,6,getTransformationMatrix(param1),0,-1,param2);
         return param2;
      }
      
      override public function render(param1:RenderSupport, param2:Number) : void
      {
         var _loc3_:Context3D = Starling.context;
         if(_loc3_ == null)
         {
            throw new MissingContextError();
         }
         if(_colorPattern == null)
         {
            return;
         }
         param1.finishQuadBatch();
         param1.raiseDrawCount();
         if(!_vertexBuffer)
         {
            createBuffers();
         }
         if(_colorUVInvalidated)
         {
            _colorUVInvalidated = false;
            _colorUVBuffer.uploadFromVector(_colorUV,0,4);
         }
         param1.applyBlendMode(true);
         var _loc4_:* = _colorPattern.width < 50;
         _loc3_.setProgram(getProgram(_loc4_));
         _loc3_.setTextureAt(0,texture.base);
         _loc3_.setTextureAt(1,_colorPattern.base);
         _loc3_.setVertexBufferAt(0,_vertexBuffer,0,"float2");
         _loc3_.setVertexBufferAt(1,_vertexBuffer,2,"float2");
         _loc3_.setVertexBufferAt(2,_colorUVBuffer,0,"float2");
         _loc3_.setProgramConstantsFromMatrix("vertex",0,param1.mvpMatrix3D,true);
         _loc3_.setProgramConstantsFromVector("fragment",0,canvasColors);
         alphaVectorConsts[3] = alpha * param2;
         _loc3_.setProgramConstantsFromVector("fragment",4,alphaVectorConsts,1);
         _loc3_.drawTriangles(_indexBuffer,0,2);
         _loc3_.setVertexBufferAt(0,null);
         _loc3_.setVertexBufferAt(1,null);
         _loc3_.setVertexBufferAt(2,null);
         _loc3_.setTextureAt(0,null);
         _loc3_.setTextureAt(1,null);
      }
      
      public function readjustSize() : void
      {
         var _loc2_:Rectangle = texture.frame;
         var _loc1_:Number = !!_loc2_?_loc2_.width:Number(texture.width);
         var _loc3_:Number = !!_loc2_?_loc2_.height:Number(texture.height);
         if(_loc1_ == 0 || _loc3_ == 0)
         {
            throw new ArgumentError("Invalid size: width and height must not be zero");
         }
         vertices[6 + 0] = _loc1_;
         vertices[6 * 2 + 0] = _loc1_;
         vertices[6 * 2 + 0 + 1] = _loc3_;
         vertices[6 * 3 + 0 + 1] = _loc3_;
      }
      
      private function createBuffers() : void
      {
         var _loc1_:Context3D = Starling.context;
         if(_loc1_ == null)
         {
            throw new MissingContextError();
         }
         if(_vertexBuffer)
         {
            _vertexBuffer.dispose();
         }
         if(_indexBuffer)
         {
            _indexBuffer.dispose();
         }
         if(_colorUVBuffer)
         {
            _colorUVBuffer.dispose();
         }
         _vertexBuffer = _loc1_.createVertexBuffer(4,6);
         _vertexBuffer.uploadFromVector(vertices,0,4);
         _indexBuffer = _loc1_.createIndexBuffer(indices.length);
         _indexBuffer.uploadFromVector(indices,0,indices.length);
         _colorUVBuffer = _loc1_.createVertexBuffer(4,2);
         _colorUVBuffer.uploadFromVector(_colorUV,0,4);
      }
      
      private function setTexCoords(param1:Number, param2:Number) : void
      {
         vertices[6 + 2] = param1;
         vertices[6 * 2 + 2] = param1;
         vertices[6 * 2 + 2 + 1] = param2;
         vertices[6 * 3 + 2 + 1] = param2;
      }
      
      private function handler_contextCreated(param1:Object) : void
      {
         createBuffers();
      }
   }
}
