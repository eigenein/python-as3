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
   
   public class RoundImage extends DisplayObject
   {
      
      private static const PROGRAM_NAME_ROUND_IMAGE:String = "roundImage";
      
      private static const NUM_VERTICES:Number = 4;
      
      private static const ELEMENTS_PER_VERTEX:Number = 4;
      
      private static const POSITION_OFFSET:int = 0;
      
      private static const UV_OFFSET:int = 2;
       
      
      private var _texture:Texture;
      
      private var smoothing:String;
      
      private var vertices:Vector.<Number>;
      
      private var indices:Vector.<uint>;
      
      private var _fragmentConsts:Vector.<Number>;
      
      private var _vertexBuffer:VertexBuffer3D;
      
      private var _indexBuffer:IndexBuffer3D;
      
      private var premultipliedAlpha:Boolean;
      
      public var circleX:Number = NaN;
      
      public var circleY:Number = NaN;
      
      public var circleR:Number = NaN;
      
      public function RoundImage(param1:Texture)
      {
         indices = new <uint>[0,1,2,2,3,0];
         _fragmentConsts = new <Number>[0,0,0,0,0,0,0,0];
         super();
         if(!param1)
         {
            throw new ArgumentError("Texture cannot be null");
         }
         vertices = new Vector.<Number>(4 * 4,true);
         this._texture = param1;
         premultipliedAlpha = param1.premultipliedAlpha;
         setTexCoords(1,1);
         _texture.adjustTexCoords(vertices,2,4 - 2);
         readjustSize();
         if(_vertexBuffer)
         {
            _vertexBuffer.uploadFromVector(vertices,0,4);
         }
         smoothing = "bilinear";
         Starling.current.stage3D.addEventListener("context3DCreate",handler_contextCreated,false,0,true);
      }
      
      private static function getProgram() : Program3D
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc4_:Starling = Starling.current;
         var _loc1_:String = "roundImage";
         if(!_loc4_.hasProgram(_loc1_))
         {
            _loc2_ = "m44 op, va0, vc0 \nmov v0, va1      \n";
            _loc3_ = "tex ft0, v0,  fs0 <2d, clamp, linear, mipnone> \nmul ft1.xy, v0.xy, fc0.zw \nsub ft1.xy, ft1.xy, fc0.xy \nmul ft1.xy, ft1.xy, ft1.xy \nadd ft1.x, ft1.x, ft1.y \nsqt ft1.x, ft1.x \nsub ft1.x, fc1.x, ft1.x \nsat ft1.x, ft1.x \nmul ft0.a, ft0.a, ft1.x \nmul ft0.a, ft0.a, fc1.y \nmov oc, ft0";
            _loc4_.registerProgramFromSource(_loc1_,_loc2_,_loc3_);
         }
         return _loc4_.getProgram(_loc1_);
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
      
      public function set texture(param1:Texture) : void
      {
         this._texture = param1;
         premultipliedAlpha = param1.premultipliedAlpha;
         setTexCoords(1,1);
         _texture.adjustTexCoords(vertices,2,4 - 2);
         if(_vertexBuffer)
         {
            _vertexBuffer.uploadFromVector(vertices,0,4);
         }
      }
      
      override public function getBounds(param1:DisplayObject, param2:Rectangle = null) : Rectangle
      {
         CustomContext3DUtils.getVerticesBounds(vertices,4,4,getTransformationMatrix(param1),0,-1,param2);
         return param2;
      }
      
      override public function render(param1:RenderSupport, param2:Number) : void
      {
         var _loc3_:Context3D = Starling.context;
         if(_loc3_ == null)
         {
            throw new MissingContextError();
         }
         param1.finishQuadBatch();
         param1.raiseDrawCount();
         if(!_vertexBuffer)
         {
            createBuffers();
         }
         param1.applyBlendMode(true);
         adjustCircleCoords();
         _loc3_.setProgram(getProgram());
         _loc3_.setTextureAt(0,_texture.base);
         _loc3_.setVertexBufferAt(0,_vertexBuffer,0,"float2");
         _loc3_.setVertexBufferAt(1,_vertexBuffer,2,"float2");
         _loc3_.setProgramConstantsFromMatrix("vertex",0,param1.mvpMatrix3D,true);
         _fragmentConsts[5] = alpha * param2;
         _loc3_.setProgramConstantsFromVector("fragment",0,_fragmentConsts);
         _loc3_.drawTriangles(_indexBuffer,0,2);
         _loc3_.setVertexBufferAt(0,null);
         _loc3_.setVertexBufferAt(1,null);
         _loc3_.setTextureAt(0,null);
      }
      
      public function readjustSize() : void
      {
         var _loc2_:Rectangle = _texture.frame;
         var _loc1_:Number = !!_loc2_?_loc2_.width:Number(_texture.width);
         var _loc3_:Number = !!_loc2_?_loc2_.height:Number(_texture.height);
         if(_loc1_ == 0 || _loc3_ == 0)
         {
            throw new ArgumentError("Invalid size: width and height must not be zero");
         }
         vertices[4 + 0] = _loc1_;
         vertices[4 * 2 + 0] = _loc1_;
         vertices[4 * 2 + 0 + 1] = _loc3_;
         vertices[4 * 3 + 0 + 1] = _loc3_;
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
      
      private function setTexCoords(param1:Number, param2:Number) : void
      {
         vertices[2] = 0;
         vertices[2 + 1] = 0;
         vertices[4 + 2] = param1;
         vertices[4 + 2 + 1] = 0;
         vertices[4 * 2 + 2] = param1;
         vertices[4 * 2 + 2 + 1] = param2;
         vertices[4 * 3 + 2] = 0;
         vertices[4 * 3 + 2 + 1] = param2;
      }
      
      private function adjustCircleCoords() : void
      {
         var _loc5_:Number = vertices[2];
         var _loc7_:Number = vertices[4 * 2 + 2];
         var _loc4_:Number = vertices[2 + 1];
         var _loc6_:Number = vertices[4 * 2 + 2 + 1];
         var _loc8_:Number = (_loc7_ - _loc5_) / _texture.nativeWidth;
         var _loc9_:Number = (_loc6_ - _loc4_) / _texture.nativeHeight;
         var _loc3_:Number = !!_texture.frame?_texture.frame.x:0;
         var _loc10_:Number = !!_texture.frame?_texture.frame.y:0;
         var _loc2_:Number = !!_texture.frame?_texture.frame.width:Number(_texture.nativeWidth);
         var _loc1_:Number = !!_texture.frame?_texture.frame.height:Number(_texture.nativeHeight);
         _fragmentConsts[0] = (circleX == circleX?circleX:Number(_loc2_ / 2)) + _loc5_ * _texture.root.nativeWidth;
         _fragmentConsts[1] = (circleY == circleY?circleY:Number(_loc2_ / 2)) + _loc4_ * _texture.root.nativeHeight;
         _fragmentConsts[2] = _texture.nativeWidth / (_loc7_ - _loc5_);
         _fragmentConsts[3] = _texture.nativeWidth / (_loc6_ - _loc4_);
         _fragmentConsts[4] = circleR == circleR?circleR:Number(_loc2_ / 2 + 1);
      }
      
      private function handler_contextCreated(param1:Object) : void
      {
         createBuffers();
      }
   }
}
