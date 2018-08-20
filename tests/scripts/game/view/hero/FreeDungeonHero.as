package game.view.hero
{
   public class FreeDungeonHero extends FreeHero
   {
      
      public static const TITAN_SCALE:Number = 0.8250000000000001;
      
      public static const HERO_SCALE:Number = 0.33;
       
      
      private var _isTitan:Boolean;
      
      public var teamIndex:int;
      
      public var isRider:Boolean = false;
      
      public var isBusy:Boolean = false;
      
      public var terrain:DungeonHeroTerrainHeight;
      
      public function FreeDungeonHero(param1:Boolean = false)
      {
         super();
         this._isTitan = param1;
         _speed = _speed * 0.75;
      }
      
      public function get isTitan() : Boolean
      {
         return _isTitan;
      }
      
      override public function advanceTime(param1:Number) : void
      {
         move(param1);
         if(movement == 0 && view.canStrafe)
         {
            if(Math.random() < 0.002)
            {
               view.win();
            }
         }
         view.position.x = position.x;
         view.position.y = position.y;
         view.position.z = position.y;
         if(terrain != null)
         {
            view.position.y = view.position.y + terrain.getHeight(position.x,position.y);
         }
         view.position.movement = movement;
         view.position.isMoveable = true;
         view.updatePosition();
      }
      
      override protected function getScale() : Number
      {
         super.getScale();
         if(_isTitan)
         {
            return 0.825;
         }
         return 0.33;
      }
   }
}
