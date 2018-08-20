package game.view.gui.tutorial
{
   import flash.display3D.Context3D;
   import flash.display3D.IndexBuffer3D;
   import flash.display3D.Program3D;
   import flash.display3D.VertexBuffer3D;
   import flash.geom.Rectangle;
   import game.view.popup.clan.editicon.CustomContext3DUtils;
   import starling.core.RenderSupport;
   import starling.core.Starling;
   import starling.display.DisplayObject;
   import starling.errors.MissingContextError;
   import starling.textures.Texture;
   
   public class CircularProgressBar extends DisplayObject
   {
      
      private static const PROGRAM_NAME:String = "circularProgressBar";
      
      private static const NUM_VERTICES:Number = 4;
      
      private static const ELEMENTS_PER_VERTEX:Number = 4;
      
      private static const POSITION_OFFSET:int = 0;
      
      private static const UV_OFFSET:int = 2;
       
      
      protected var circleInnerR:Number;
      
      protected var circleWidth:Number;
      
      protected var circleBlurProportion:Number;
      
      public var progress:Number = 0.7;
      
      protected var circleCenterX:Number;
      
      protected var circleCenterY:Number;
      
      private var circleParamsVector:Vector.<Number>;
      
      private var alphaVectorConsts:Vector.<Number>;
      
      private var texture:Texture;
      
      private var color:uint;
      
      private var smoothing:String;
      
      private var vertices:Vector.<Number>;
      
      private var indices:Vector.<uint>;
      
      private var _vertexBuffer:VertexBuffer3D;
      
      private var _indexBuffer:IndexBuffer3D;
      
      private var premultipliedAlpha:Boolean;
      
      public function CircularProgressBar(param1:Texture, param2:Number, param3:Number, param4:uint, param5:Number, param6:Number, param7:Number)
      {
         circleParamsVector = new <Number>[0,0,0,0];
         alphaVectorConsts = new <Number>[1,1,1,1];
         indices = new <uint>[0,1,2,2,3,0];
         super();
         if(!param1)
         {
            throw new ArgumentError("Texture cannot be null");
         }
         this.texture = param1;
         this.color = param4;
         this.circleInnerR = param5;
         this.circleWidth = param6 - param5;
         this.circleBlurProportion = (param7 - param5) / (param6 - param5);
         vertices = new Vector.<Number>(4 * 4,true);
         readjustSize(param2,param3);
         premultipliedAlpha = param1.premultipliedAlpha;
         setTexCoords(1,1);
         param1.adjustTexCoords(vertices,2,4 - 2);
         smoothing = "bilinear";
         Starling.current.stage3D.addEventListener("context3DCreate",handler_contextCreated,false,0,true);
      }
      
      private static function getProgram() : Program3D
      {
         var _loc3_:* = null;
         var _loc1_:* = null;
         var _loc2_:Starling = Starling.current;
         if(!_loc2_.hasProgram("circularProgressBar"))
         {
            _loc3_ = "m44 vt1, va0, vc0 \nmov v1, va0 \nmov v2, va1 \nmov op, vt1 \nmov v0, vc4 \n";
            _loc1_ = "sub ft0.xy, v1.xy, fc0.xy \nmul ft0.xy, ft0.xy, ft0.xy \nadd ft0.x, ft0.x, ft0.y\nsqt ft0.x, ft0.x \nsub ft0.x, ft0.x, fc1.x \nsat ft0.z, ft0.x \ndiv ft0.x, ft0.x, fc1.y \nsub ft0.x, fc1.z, ft0.x \nmov ft0.y, fc1.z \nsub ft0.y, fc1.w, ft0.y \ndiv ft0.x, ft0.x, ft0.y \nadd ft0.x, ft0.x, fc1.w \nsat ft0.x, ft0.x \ntex ft1, v2, fs0 <2d, clamp, " + "linear" + ", mipnone>\n" + "sub ft1.x, fc0.w, ft1.x \n" + "mul ft1.x, ft1.x, fc0.z \n" + "sat ft1.x, ft1.x \n" + "mul ft0.x, ft0.x, ft1.x \n" + "mul ft0.x, ft0.x, ft0.z \n" + "mul ft0.a, v0.a, ft0.x \n" + "mov oc, ft0";
            _loc2_.registerProgramFromSource("circularProgressBar",_loc3_,_loc1_);
         }
         return _loc2_.getProgram("circularProgressBar");
      }
      
      override public function dispose() : void
      {
         super.dispose();
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
      }
      
      public function readjustSize(param1:Number, param2:Number) : void
      {
         if(param1 == 0 || param2 == 0)
         {
            throw new ArgumentError("Invalid size: width and height must not be zero");
         }
         vertices[4 + 0] = param1;
         vertices[4 * 2 + 0] = param1;
         vertices[4 * 2 + 0 + 1] = param2;
         vertices[4 * 3 + 0 + 1] = param2;
         this.circleCenterX = param1 * 0.5;
         this.circleCenterY = param2 * 0.5;
      }
      
      private function setTexCoords(param1:Number, param2:Number) : void
      {
         vertices[4 + 2] = param1;
         vertices[4 * 2 + 2] = param1;
         vertices[4 * 2 + 2 + 1] = param2;
         vertices[4 * 3 + 2 + 1] = param2;
      }
      
      override public function getBounds(param1:DisplayObject, param2:Rectangle = null) : Rectangle
      {
         CustomContext3DUtils.getVerticesBounds(vertices,4,4,getTransformationMatrix(param1),0,-1,param2);
         return param2;
      }
      
      override public function render(param1:RenderSupport, param2:Number) : void
      {
         if(!_vertexBuffer)
         {
            createBuffers();
         }
         param1.finishQuadBatch();
         param1.raiseDrawCount();
         var _loc3_:Number = param2 * this.alpha;
         alphaVectorConsts[0] = _loc3_ * (color >> 16 & 255) / 255;
         alphaVectorConsts[1] = _loc3_ * (color >> 8 & 255) / 255;
         alphaVectorConsts[2] = _loc3_ * (color & 255) / 255;
         alphaVectorConsts[3] = _loc3_;
         var _loc5_:Context3D = Starling.context;
         if(_loc5_ == null)
         {
            throw new MissingContextError();
         }
         param1.blendMode = blendMode;
         param1.applyBlendMode(true);
         _loc5_.setProgram(getProgram());
         _loc5_.setVertexBufferAt(0,_vertexBuffer,0,"float2");
         _loc5_.setVertexBufferAt(1,_vertexBuffer,2,"float2");
         _loc5_.setProgramConstantsFromMatrix("vertex",0,param1.mvpMatrix3D,true);
         _loc5_.setProgramConstantsFromVector("vertex",4,alphaVectorConsts,1);
         var _loc4_:Number = (circleInnerR + circleWidth * circleBlurProportion) * 3.14159265358979;
         circleParamsVector[0] = circleCenterX;
         circleParamsVector[1] = circleCenterY;
         circleParamsVector[2] = _loc4_;
         circleParamsVector[3] = progress + 1 / _loc4_;
         circleParamsVector[4] = circleInnerR;
         circleParamsVector[5] = circleWidth;
         circleParamsVector[6] = circleBlurProportion;
         circleParamsVector[7] = 1;
         _loc5_.setProgramConstantsFromVector("fragment",0,circleParamsVector,2);
         _loc5_.setTextureAt(0,texture.base);
         _loc5_.drawTriangles(_indexBuffer,0,2);
         _loc5_.setVertexBufferAt(0,null);
         _loc5_.setVertexBufferAt(1,null);
         _loc5_.setTextureAt(0,null);
         _loc5_.setTextureAt(1,null);
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
         _vertexBuffer = _loc1_.createVertexBuffer(4,4);
         _vertexBuffer.uploadFromVector(vertices,0,4);
         _indexBuffer = _loc1_.createIndexBuffer(indices.length);
         _indexBuffer.uploadFromVector(indices,0,indices.length);
      }
      
      private function handler_contextCreated(param1:Object) : void
      {
         createBuffers();
      }
   }
}
