package game.view.hero
{
   public class FreeClanHero extends FreeHero
   {
      
      public static const TITAN_SCALE:Number = 0.75;
      
      public static const HERO_SCALE:Number = 0.35;
       
      
      private var isTitan:Boolean;
      
      public function FreeClanHero(param1:Boolean = false)
      {
         this.isTitan = param1;
         super();
      }
      
      override public function advanceTime(param1:Number) : void
      {
         if(movement == 0 && view.canStrafe)
         {
            if(Math.random() < 0.002)
            {
               view.win();
            }
         }
         view.position.scale = 0.95 / (1 - position.y * 0.00075);
         view.position.x = position.x * view.position.scale;
         view.position.y = position.y * 0.35;
         view.position.z = position.y;
         view.position.movement = movement;
         view.position.isMoveable = true;
         view.updatePosition();
      }
      
      override protected function getScale() : Number
      {
         if(isTitan)
         {
            return 0.75;
         }
         return 0.35;
      }
   }
}
