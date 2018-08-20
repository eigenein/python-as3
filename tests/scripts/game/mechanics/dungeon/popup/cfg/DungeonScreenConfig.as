package game.mechanics.dungeon.popup.cfg
{
   public class DungeonScreenConfig
   {
      
      public static const SCREEN_WIDTH:int = 1000;
      
      public static const SCREEN_HEIGHT:int = 640;
      
      public static const FLOOR_PADDING_LEFT:int = 290;
      
      public static const FLOOR_PADDING_RIGHT:int = 290;
      
      public static const RENDERER_WIDTH:int = 1000;
      
      public static const RENDERER_HEIGHT:int = 490;
      
      public static const HORIZONTAL_GAP:int = 300;
      
      public static const VERTICAL_GAP:int = 650;
      
      public static const HORIZONTAL_BRIDGE_CAMERA_OFFSET:int = 150;
      
      public static const ROOMS_PER_FLOOR:int = 5;
      
      public static const MANUAL_SCROLL:Boolean = false;
       
      
      public function DungeonScreenConfig()
      {
         super();
      }
      
      public static function isRightExit(param1:*) : Boolean
      {
         return int((param1 - 1) / 5) % 2 == 0;
      }
   }
}
