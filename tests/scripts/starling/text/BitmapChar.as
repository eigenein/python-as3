package starling.text
{
   import flash.utils.Dictionary;
   import starling.display.Image;
   import starling.textures.Texture;
   
   public class BitmapChar
   {
       
      
      private var mTexture:Texture;
      
      private var mCharID:int;
      
      private var mXOffset:Number;
      
      private var mYOffset:Number;
      
      private var mXAdvance:Number;
      
      private var mKernings:Dictionary;
      
      public function BitmapChar(param1:int, param2:Texture, param3:Number, param4:Number, param5:Number)
      {
         super();
         mCharID = param1;
         mTexture = param2;
         mXOffset = param3;
         mYOffset = param4;
         mXAdvance = param5;
         mKernings = null;
      }
      
      public function addKerning(param1:int, param2:Number) : void
      {
         if(mKernings == null)
         {
            mKernings = new Dictionary();
         }
         mKernings[param1] = param2;
      }
      
      public function getKerning(param1:int) : Number
      {
         if(mKernings == null || mKernings[param1] == undefined)
         {
            return 0;
         }
         return mKernings[param1];
      }
      
      public function createImage() : Image
      {
         return new Image(mTexture);
      }
      
      public function get charID() : int
      {
         return mCharID;
      }
      
      public function get xOffset() : Number
      {
         return mXOffset;
      }
      
      public function get yOffset() : Number
      {
         return mYOffset;
      }
      
      public function get xAdvance() : Number
      {
         return mXAdvance;
      }
      
      public function get texture() : Texture
      {
         return mTexture;
      }
      
      public function get width() : Number
      {
         return mTexture.width;
      }
      
      public function get height() : Number
      {
         return mTexture.height;
      }
   }
}
