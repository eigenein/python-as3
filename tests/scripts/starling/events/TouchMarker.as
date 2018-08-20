package starling.events
{
   import flash.display.BitmapData;
   import flash.display.Shape;
   import flash.geom.Point;
   import starling.core.Starling;
   import starling.display.Image;
   import starling.display.Sprite;
   import starling.textures.Texture;
   
   class TouchMarker extends Sprite
   {
       
      
      private var mCenter:Point;
      
      private var mTexture:Texture;
      
      function TouchMarker()
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         super();
         mCenter = new Point();
         mTexture = createTexture();
         _loc2_ = 0;
         while(_loc2_ < 2)
         {
            _loc1_ = new Image(mTexture);
            _loc1_.pivotX = mTexture.width / 2;
            _loc1_.pivotY = mTexture.height / 2;
            _loc1_.touchable = false;
            addChild(_loc1_);
            _loc2_++;
         }
      }
      
      override public function dispose() : void
      {
         mTexture.dispose();
         super.dispose();
      }
      
      public function moveMarker(param1:Number, param2:Number, param3:Boolean = false) : void
      {
         if(param3)
         {
            mCenter.x = mCenter.x + (param1 - realMarker.x);
            mCenter.y = mCenter.y + (param2 - realMarker.y);
         }
         realMarker.x = param1;
         realMarker.y = param2;
         mockMarker.x = 2 * mCenter.x - param1;
         mockMarker.y = 2 * mCenter.y - param2;
      }
      
      public function moveCenter(param1:Number, param2:Number) : void
      {
         mCenter.x = param1;
         mCenter.y = param2;
         moveMarker(realX,realY);
      }
      
      private function createTexture() : Texture
      {
         var _loc5_:Number = Starling.contentScaleFactor;
         var _loc6_:Number = 12 * _loc5_;
         var _loc4_:int = 32 * _loc5_;
         var _loc7_:int = 32 * _loc5_;
         var _loc3_:Number = 1.5 * _loc5_;
         var _loc2_:Shape = new Shape();
         _loc2_.graphics.lineStyle(_loc3_,0,0.3);
         _loc2_.graphics.drawCircle(_loc4_ / 2,_loc7_ / 2,_loc6_ + _loc3_);
         _loc2_.graphics.beginFill(16777215,0.4);
         _loc2_.graphics.lineStyle(_loc3_,16777215);
         _loc2_.graphics.drawCircle(_loc4_ / 2,_loc7_ / 2,_loc6_);
         _loc2_.graphics.endFill();
         var _loc1_:BitmapData = new BitmapData(_loc4_,_loc7_,true,0);
         _loc1_.draw(_loc2_);
         return Texture.fromBitmapData(_loc1_,false,false,_loc5_);
      }
      
      private function get realMarker() : Image
      {
         return getChildAt(0) as Image;
      }
      
      private function get mockMarker() : Image
      {
         return getChildAt(1) as Image;
      }
      
      public function get realX() : Number
      {
         return realMarker.x;
      }
      
      public function get realY() : Number
      {
         return realMarker.y;
      }
      
      public function get mockX() : Number
      {
         return mockMarker.x;
      }
      
      public function get mockY() : Number
      {
         return mockMarker.y;
      }
   }
}
