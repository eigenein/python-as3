package game.view.gui.components
{
   import flash.display3D.Context3D;
   import flash.display3D.Program3D;
   import flash.geom.Rectangle;
   import starling.core.Starling;
   import starling.filters.FragmentFilter;
   import starling.textures.Texture;
   
   public class ListAlphaMaskFilter extends FragmentFilter
   {
      
      private static const PROGRAM_NAME:String = "ListAlphaMask";
       
      
      private var mShaderProgram:Program3D;
      
      private var params:Vector.<Number>;
      
      public var gradientHeight:Number;
      
      public var isHorizontal:Boolean;
      
      public var topGradientAlpha:Number = 0;
      
      public var bottomGradientAlpha:Number = 0;
      
      public function ListAlphaMaskFilter(param1:Number = 60, param2:Boolean = false)
      {
         params = new Vector.<Number>(16,true);
         this.gradientHeight = param1;
         this.isHorizontal = param2;
         super();
      }
      
      override protected function createPrograms() : void
      {
         var _loc2_:* = null;
         var _loc3_:Starling = Starling.current;
         var _loc1_:String = !!isHorizontal?"ListAlphaMaskh":"ListAlphaMask";
         if(_loc3_.hasProgram(_loc1_))
         {
            mShaderProgram = _loc3_.getProgram(_loc1_);
         }
         else
         {
            _loc2_ = "tex ft0, v0,  fs0 <2d, clamp, linear, mipnone>  \n" + (!!isHorizontal?"mul ft1.xy, v0.xx, fc0.yw\t\n":"mul ft1.xy, v0.yy, fc0.yw\t\n") + "add ft1.xy, ft1.xy, fc0.xz\t\n" + "sat ft1.xy, ft1.xy\t\n" + "pow ft1.xy, ft1.xy, fc1.xy\t\n" + "sub ft1.xy, fc1.ww, ft1.xy\t\n" + "mul ft1.xy, ft1.xy, ft1.xy\t\n" + "mul ft1.x, ft1.x, ft1.y\t\n" + "mul ft0.xyzw, ft0.xyzw, ft1.xxxx\t\n" + "mov oc, ft0                    \n";
            mShaderProgram = _loc3_.registerProgramFromSource(_loc1_,"m44 op, va0, vc0 \nmov v0, va1      \n",_loc2_);
         }
      }
      
      override protected function activate(param1:int, param2:Context3D, param3:Texture) : void
      {
         var _loc5_:Rectangle = mHelperRect;
         var _loc4_:Rectangle = mHelperRect2;
         if(isHorizontal)
         {
            params[0] = 1;
            params[1] = -_loc4_.width / gradientHeight;
            params[2] = 1 - _loc5_.width / gradientHeight;
            params[3] = _loc4_.width / gradientHeight;
         }
         else
         {
            params[0] = 1;
            params[1] = -_loc4_.height / gradientHeight;
            params[2] = 1 - _loc5_.height / gradientHeight;
            params[3] = _loc4_.height / gradientHeight;
         }
         params[4] = 10 - topGradientAlpha * 8;
         params[5] = 10 - bottomGradientAlpha * 8;
         params[6] = 0;
         params[7] = 1;
         param2.setProgramConstantsFromVector("fragment",0,params);
         param2.setProgram(mShaderProgram);
      }
   }
}
