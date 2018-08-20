package game.screen
{
   import starling.animation.Juggler;
   import starling.display.DisplayObjectContainer;
   import starling.display.Sprite;
   
   public class GameScreen
   {
       
      
      private var priority:int;
      
      private var _juggler:Juggler;
      
      public const graphics:Sprite = new Sprite();
      
      public function GameScreen(param1:int)
      {
         _juggler = new Juggler();
         super();
         this.priority = param1;
      }
      
      public static function sortByPriority(param1:GameScreen, param2:GameScreen) : int
      {
         return param1.priority - param2.priority;
      }
      
      public function get juggler() : Juggler
      {
         return _juggler;
      }
      
      public function show(param1:DisplayObjectContainer) : void
      {
         param1.addChildAt(graphics,0);
      }
      
      public function hide() : void
      {
         if(graphics && graphics.parent)
         {
            graphics.parent.removeChild(graphics);
         }
      }
      
      public function isPermanent() : Boolean
      {
         return true;
      }
   }
}
