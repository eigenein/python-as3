package game.view.gui.components
{
   import flash.display3D.Context3D;
   import flash.display3D.Program3D;
   import flash.geom.Rectangle;
   import flash.utils.getTimer;
   import starling.core.Starling;
   import starling.filters.FragmentFilter;
   import starling.textures.Texture;
   
   public class RotatingGlowImageFilter extends FragmentFilter
   {
      
      private static const PROGRAM_NAME:String = "RotatingGlowImage";
       
      
      private var mShaderProgram:Program3D;
      
      private var params:Vector.<Number>;
      
      public function RotatingGlowImageFilter()
      {
         params = new Vector.<Number>(16,true);
         super();
      }
      
      override protected function createPrograms() : void
      {
         var _loc1_:* = null;
         var _loc2_:Starling = Starling.current;
         if(_loc2_.hasProgram("RotatingGlowImage"))
         {
            mShaderProgram = _loc2_.getProgram("RotatingGlowImage");
         }
         else
         {
            _loc1_ = "tex ft0, v0,  fs0 <2d, clamp, linear, mipnone>  \nmul ft1.w, ft0.x, ft0.y\t\nseq ft1.w, ft1.w, fc2.x\t\nmul ft1.xyz, ft0.xyz, fc0.xyz\t\ndiv ft1.xyz, ft1.xyz, ft0.www\t\nadd ft1.x, ft1.x, ft1.y\t\nadd ft1.x, ft1.x, ft1.z\t\nadd ft1.x, ft1.x, fc0.w\t\nmul ft1.x, ft1.x, ft1.w\t\nsub ft1.xy, ft1.xx, fc1.xy\t\nabs ft1.xy, ft1.xy\t\nsub ft1.xy, fc1.zz, ft1.xy\t\nmax ft1.x, ft1.x, ft1.y\t\nsub ft1.x, ft1.x, fc1.w\t\nmov ft1.y, fc1.z\t\nsub ft1.y, ft1.y, fc1.w\t\nsat ft1.x, ft1.x\t\ndiv ft1.x, ft1.x, ft1.y\t\nmov ft1.y, ft1.x\t\nmul ft0.x, ft1.x, ft0.w\t\nmul ft1.x, ft1.y, ft1.y\t\nmul ft0.y, ft1.x, ft0.w\t\nmul ft1.x, ft1.x, ft1.x\t\nmul ft1.x, ft1.x, fc1.w\t\nmul ft0.z, ft1.x, ft0.w\t\nmov oc, ft0                    \n";
            mShaderProgram = _loc2_.registerProgramFromSource("RotatingGlowImage","m44 op, va0, vc0 \nmov v0, va1      \n",_loc1_);
         }
      }
      
      override protected function activate(param1:int, param2:Context3D, param3:Texture) : void
      {
         var _loc8_:Rectangle = mHelperRect;
         var _loc7_:Rectangle = mHelperRect2;
         var _loc5_:* = 1.33;
         var _loc9_:Number = getTimer() / _loc5_ % 1000 / 500;
         if(_loc9_ > 1)
         {
            _loc9_ = _loc9_ - 2;
         }
         var _loc6_:* = 12.5663706143592;
         var _loc4_:Number = _loc8_.width - 20;
         var _loc10_:Number = _loc8_.height - 20;
         var _loc11_:Number = 0.5 * (_loc6_ + _loc4_ + _loc10_);
         params[0] = _loc4_ / _loc11_;
         params[1] = -_loc10_ / _loc11_;
         params[2] = _loc6_ / _loc11_;
         params[3] = _loc10_ / _loc11_;
         params[4] = _loc9_;
         params[5] = _loc9_ + 2;
         params[6] = 1;
         params[7] = 0.4;
         params[8] = 0;
         param2.setProgramConstantsFromVector("fragment",0,params);
         param2.setProgram(mShaderProgram);
      }
   }
}
