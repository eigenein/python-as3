package game.view.popup.clan.editicon
{
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import starling.utils.MatrixUtil;
   
   public class CustomContext3DUtils
   {
      
      private static const sHelperPoint:Point = new Point();
      
      private static const POSITION_OFFSET:int = 0;
       
      
      public function CustomContext3DUtils()
      {
         super();
      }
      
      public static function getVerticesBounds(param1:Vector.<Number>, param2:int, param3:int, param4:Matrix = null, param5:int = 0, param6:int = -1, param7:Rectangle = null) : Rectangle
      {
         var _loc13_:* = NaN;
         var _loc12_:* = NaN;
         var _loc8_:int = 0;
         var _loc15_:Number = NaN;
         var _loc11_:int = 0;
         var _loc14_:Number = NaN;
         if(param7 == null)
         {
            param7 = new Rectangle();
         }
         if(param6 < 0 || param5 + param6 > param2)
         {
            param6 = param2 - param5;
         }
         if(param6 == 0)
         {
            if(param4 == null)
            {
               param7.setEmpty();
            }
            else
            {
               MatrixUtil.transformCoords(param4,0,0,sHelperPoint);
               param7.setTo(sHelperPoint.x,sHelperPoint.y,0,0);
            }
         }
         else
         {
            _loc13_ = 1.79769313486232e308;
            var _loc10_:* = -1.79769313486232e308;
            _loc12_ = 1.79769313486232e308;
            var _loc9_:* = -1.79769313486232e308;
            _loc8_ = param5 * param3 + 0;
            if(param4 == null)
            {
               _loc11_ = 0;
               while(_loc11_ < param6)
               {
                  _loc14_ = param1[_loc8_];
                  _loc15_ = param1[int(_loc8_ + 1)];
                  _loc8_ = _loc8_ + param2;
                  if(_loc13_ > _loc14_)
                  {
                     _loc13_ = _loc14_;
                  }
                  if(_loc10_ < _loc14_)
                  {
                     _loc10_ = _loc14_;
                  }
                  if(_loc12_ > _loc15_)
                  {
                     _loc12_ = _loc15_;
                  }
                  if(_loc9_ < _loc15_)
                  {
                     _loc9_ = _loc15_;
                  }
                  _loc11_++;
               }
            }
            else
            {
               _loc11_ = 0;
               while(_loc11_ < param6)
               {
                  _loc14_ = param1[_loc8_];
                  _loc15_ = param1[int(_loc8_ + 1)];
                  _loc8_ = _loc8_ + param2;
                  MatrixUtil.transformCoords(param4,_loc14_,_loc15_,sHelperPoint);
                  if(_loc13_ > sHelperPoint.x)
                  {
                     _loc13_ = Number(sHelperPoint.x);
                  }
                  if(_loc10_ < sHelperPoint.x)
                  {
                     _loc10_ = Number(sHelperPoint.x);
                  }
                  if(_loc12_ > sHelperPoint.y)
                  {
                     _loc12_ = Number(sHelperPoint.y);
                  }
                  if(_loc9_ < sHelperPoint.y)
                  {
                     _loc9_ = Number(sHelperPoint.y);
                  }
                  _loc11_++;
               }
            }
            param7.setTo(_loc13_,_loc12_,_loc10_ - _loc13_,_loc9_ - _loc12_);
         }
         return param7;
      }
   }
}
