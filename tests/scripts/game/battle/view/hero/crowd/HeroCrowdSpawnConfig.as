package game.battle.view.hero.crowd
{
   public class HeroCrowdSpawnConfig
   {
       
      
      public var spawnCooldown:Number = 0.1;
      
      public var groupSpawnCooldown:Number = 1.5;
      
      public var groupSpawnCooldownDispersion:Number = 1;
      
      public var groupSpawnCount:Number = 5;
      
      public var groupSpawnCountDispersion:Number = 1;
      
      public var maxCount:int = 25;
      
      public var spawnX:int = 1000;
      
      public var direction:int = -1;
      
      public var scale:Number = 0.3;
      
      public var heroes:Vector.<int>;
      
      public var spawnPositions:Vector.<HeroCrowdSpawnPosition>;
      
      public function HeroCrowdSpawnConfig()
      {
         heroes = new <int>[1001,1002,1003,1004];
         super();
      }
   }
}
