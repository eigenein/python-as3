package game.view.gui.tutorial
{
   import flash.display3D.Context3D;
   import flash.display3D.IndexBuffer3D;
   import flash.display3D.Program3D;
   import flash.display3D.VertexBuffer3D;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import starling.core.RenderSupport;
   import starling.core.Starling;
   import starling.display.DisplayObject;
   import starling.errors.MissingContextError;
   import starling.utils.VertexData;
   
   public class TutorialDarknessFragmentCircle extends DisplayObject
   {
      
      private static const PROGRAM_NAME:String = "drawCircle";
       
      
      protected var circleR:Number;
      
      protected var circleCenterX:Number;
      
      protected var circleCenterY:Number;
      
      protected var circleBlurBorder:Number = 1;
      
      private var circleParamsVector:Vector.<Number>;
      
      private var alphaVectorConsts:Vector.<Number>;
      
      private var mVertexData:VertexData;
      
      private var mIndexData:Vector.<uint>;
      
      private var mVertexBuffer:VertexBuffer3D;
      
      private var mIndexBuffer:IndexBuffer3D;
      
      public function TutorialDarknessFragmentCircle(param1:Number, param2:Number, param3:uint)
      {
         circleParamsVector = new <Number>[0,0,0,0];
         alphaVectorConsts = new <Number>[1,1,1,1];
         circleR = 0;
         circleCenterY = 0;
         circleCenterX = 0;
         super();
         mVertexData = new VertexData(4);
         mVertexData.setUniformColor(param3);
         if(param1 == param1 && param2 == param2)
         {
            setSize(param1,param2);
         }
         mIndexData = new <uint>[0,1,2,2,3,0];
         Starling.current.stage3D.addEventListener("context3DCreate",handler_contextCreated,false,0,true);
      }
      
      private static function getProgram() : Program3D
      {
         var _loc3_:* = null;
         var _loc1_:* = null;
         var _loc2_:Starling = Starling.current;
         if(!_loc2_.hasProgram("drawCircle"))
         {
            _loc3_ = "m44 vt1, va0, vc0 \nmov v1, va0 \nmov op, vt1 \nmul v0, va1, vc4 \n";
            _loc1_ = "sub ft0.xy, v1.xy, fc0.xy \nmul ft0.xy, ft0.xy, ft0.xy \nadd ft0.x, ft0.x, ft0.y\nsqt ft0.x, ft0.x \nsub ft0.x, ft0.x, fc0.w \nmul ft0.x, ft0.x, fc0.z \nsat ft0.x, ft0.x \nmul ft0, v0, ft0.xxxx \nmov oc, ft0";
            _loc2_.registerProgramFromSource("drawCircle",_loc3_,_loc1_);
         }
         return _loc2_.getProgram("drawCircle");
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(mVertexBuffer)
         {
            mVertexBuffer.dispose();
            mVertexBuffer = null;
         }
         if(mIndexBuffer)
         {
            mIndexBuffer.dispose();
            mIndexBuffer = null;
         }
      }
      
      public function setSize(param1:Number, param2:Number) : void
      {
         mVertexData.setPosition(0,0,0);
         mVertexData.setPosition(1,param1,0);
         mVertexData.setPosition(2,param1,param2);
         mVertexData.setPosition(3,0,param2);
      }
      
      override public function getBounds(param1:DisplayObject, param2:Rectangle = null) : Rectangle
      {
         if(param2 == null)
         {
            param2 = new Rectangle();
         }
         var _loc3_:Matrix = getTransformationMatrix(param1);
         return mVertexData.getBounds(_loc3_,0,-1,param2);
      }
      
      override public function render(param1:RenderSupport, param2:Number) : void
      {
         if(!mVertexBuffer)
         {
            createBuffers();
         }
         param1.finishQuadBatch();
         param1.raiseDrawCount();
         alphaVectorConsts[3] = param2 * this.alpha;
         var _loc3_:Context3D = Starling.context;
         if(_loc3_ == null)
         {
            throw new MissingContextError();
         }
         param1.applyBlendMode(true);
         _loc3_.setProgram(getProgram());
         _loc3_.setVertexBufferAt(0,mVertexBuffer,0,"float2");
         _loc3_.setVertexBufferAt(1,mVertexBuffer,2,"float4");
         _loc3_.setProgramConstantsFromMatrix("vertex",0,param1.mvpMatrix3D,true);
         _loc3_.setProgramConstantsFromVector("vertex",4,alphaVectorConsts,1);
         circleParamsVector[0] = circleCenterX;
         circleParamsVector[1] = circleCenterY;
         circleParamsVector[2] = 1 / circleBlurBorder;
         circleParamsVector[3] = circleR;
         _loc3_.setProgramConstantsFromVector("fragment",0,circleParamsVector,1);
         _loc3_.drawTriangles(mIndexBuffer,0,2);
         _loc3_.setVertexBufferAt(0,null);
         _loc3_.setVertexBufferAt(1,null);
      }
      
      private function createBuffers() : void
      {
         var _loc1_:Context3D = Starling.context;
         if(_loc1_ == null)
         {
            throw new MissingContextError();
         }
         if(mVertexBuffer)
         {
            mVertexBuffer.dispose();
         }
         if(mIndexBuffer)
         {
            mIndexBuffer.dispose();
         }
         mVertexBuffer = _loc1_.createVertexBuffer(mVertexData.numVertices,8);
         mVertexBuffer.uploadFromVector(mVertexData.rawData,0,mVertexData.numVertices);
         mIndexBuffer = _loc1_.createIndexBuffer(mIndexData.length);
         mIndexBuffer.uploadFromVector(mIndexData,0,mIndexData.length);
      }
      
      private function handler_contextCreated(param1:Object) : void
      {
         createBuffers();
      }
   }
}
