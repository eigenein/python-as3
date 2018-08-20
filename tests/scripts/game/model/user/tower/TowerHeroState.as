package game.model.user.tower
{
   import battle.data.HeroState;
   
   public class TowerHeroState extends HeroState
   {
       
      
      private var _maxHp:int;
      
      public function TowerHeroState(param1:*)
      {
         super(param1.hp,param1.energy,param1.isDead);
         _maxHp = param1.maxHp;
      }
      
      public function get maxHp() : int
      {
         return _maxHp;
      }
      
      public function setup(param1:*) : void
      {
         _maxHp = param1.maxHp;
         this.energy = param1.energy;
         this.hp = param1.hp;
         this.isDead = param1.isDead;
      }
   }
}
