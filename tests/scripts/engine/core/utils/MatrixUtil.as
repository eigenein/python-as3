package engine.core.utils
{
   import flash.geom.Matrix;
   
   public class MatrixUtil
   {
      
      private static var _identityMatrix:Matrix = new Matrix();
      
      private static var T:Matrix = new Matrix();
      
      public static const IDENTITY:Matrix = new Matrix();
      
      public static const FLIP_X:Matrix = new Matrix(-1);
       
      
      public function MatrixUtil()
      {
         super();
      }
      
      public static function concat(param1:Matrix, param2:Matrix, param3:Matrix) : void
      {
         if(param1 == null)
         {
            param1 = _identityMatrix;
         }
         if(param2 == null)
         {
            param2 = _identityMatrix;
         }
         param3.a = param1.a * param2.a + param1.b * param2.c;
         param3.b = param1.a * param2.b + param1.b * param2.d;
         param3.c = param1.c * param2.a + param1.d * param2.c;
         param3.d = param1.c * param2.b + param1.d * param2.d;
         param3.tx = param1.tx * param2.a + param1.ty * param2.c + param2.tx;
         param3.ty = param1.tx * param2.b + param1.ty * param2.d + param2.ty;
      }
      
      public static function concatInPlace(param1:Matrix, param2:Matrix) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(param2 == null)
         {
            param2 = _identityMatrix;
         }
         T.a = param1.a * param2.a + param1.b * param2.c;
         T.b = param1.a * param2.b + param1.b * param2.d;
         T.c = param1.c * param2.a + param1.d * param2.c;
         T.d = param1.c * param2.b + param1.d * param2.d;
         T.tx = param1.tx * param2.a + param1.ty * param2.c + param2.tx;
         T.ty = param1.tx * param2.b + param1.ty * param2.d + param2.ty;
         param1.a = T.a;
         param1.b = T.b;
         param1.c = T.c;
         param1.d = T.d;
         param1.tx = T.tx;
         param1.ty = T.ty;
      }
      
      public static function concatInPlaceRight(param1:Matrix, param2:Matrix) : void
      {
         if(param2 == null)
         {
            return;
         }
         if(param2 == null)
         {
            param2 = _identityMatrix;
         }
         T.a = param2.a * param1.a + param2.b * param1.c;
         T.b = param2.a * param1.b + param2.b * param1.d;
         T.c = param2.c * param1.a + param2.d * param1.c;
         T.d = param2.c * param1.b + param2.d * param1.d;
         T.tx = param2.tx * param1.a + param2.ty * param1.c + param1.tx;
         T.ty = param2.tx * param1.b + param2.ty * param1.d + param1.ty;
         param1.a = T.a;
         param1.b = T.b;
         param1.c = T.c;
         param1.d = T.d;
         param1.tx = T.tx;
         param1.ty = T.ty;
      }
   }
}
