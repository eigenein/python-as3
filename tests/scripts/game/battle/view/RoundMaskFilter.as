package game.battle.view
{
   import flash.display3D.Context3D;
   import flash.display3D.Program3D;
   import flash.display3D.VertexBuffer3D;
   import starling.core.Starling;
   import starling.filters.FragmentFilter;
   import starling.textures.Texture;
   
   public class RoundMaskFilter extends FragmentFilter
   {
       
      
      private var consts:Vector.<Number>;
      
      private var _colorUV:Vector.<Number>;
      
      private var _colorTextureUVBuffer:VertexBuffer3D;
      
      private var _program:Program3D;
      
      public function RoundMaskFilter(param1:Number, param2:Number, param3:Number)
      {
         super();
         consts = new <Number>[param1,param2,param3,0];
         _colorUV = new <Number>[0,0,1,0,0,1,1,1];
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(_colorTextureUVBuffer)
         {
            _colorTextureUVBuffer.dispose();
            _colorTextureUVBuffer = null;
         }
      }
      
      override protected function onContextCreated(param1:Object) : void
      {
         super.onContextCreated(param1);
         _colorTextureUVBuffer = null;
      }
      
      override protected function createPrograms() : void
      {
         _program = createProgram();
      }
      
      protected function createProgram() : Program3D
      {
         var _loc1_:String = "roundMaskFilter";
         var _loc4_:Starling = Starling.current;
         if(_loc4_.hasProgram(_loc1_))
         {
            return _loc4_.getProgram(_loc1_);
         }
         var _loc2_:String = "m44 op, va0, vc0 \nmov v0, va1      \nmov v1, va2\n";
         var _loc3_:String = "tex ft0, v0,  fs0 <2d, clamp, linear, mipnone> \nsub ft1.xy, v1.xy, fc0.xy \nmul ft1.xy, ft1.xy, ft1.xy \nadd ft1.x, ft1.x, ft1.y \nsqt ft1.x, ft1.x \nsub ft1.x, fc0.z, ft1.x \nsat ft1.x, ft1.x \nmul ft0.a, ft0.a, ft1.x \nmov oc, ft0";
         return _loc4_.registerProgramFromSource(_loc1_,_loc2_,_loc3_);
      }
      
      override protected function activate(param1:int, param2:Context3D, param3:Texture) : void
      {
         if(_colorTextureUVBuffer == null)
         {
            _colorTextureUVBuffer = Starling.context.createVertexBuffer(4,2);
         }
         param2.setVertexBufferAt(2,_colorTextureUVBuffer,0,"float2");
         param2.setProgramConstantsFromVector("fragment",0,consts);
         param2.setProgram(_program);
         var _loc4_:* = param3.width;
         _colorUV[6] = _loc4_;
         _colorUV[2] = _loc4_;
         _loc4_ = param3.height;
         _colorUV[7] = _loc4_;
         _colorUV[5] = _loc4_;
         _colorTextureUVBuffer.uploadFromVector(_colorUV,0,4);
      }
   }
}
