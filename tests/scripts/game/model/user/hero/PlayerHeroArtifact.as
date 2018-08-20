package game.model.user.hero
{
   import game.data.cost.CostData;
   import game.data.storage.artifact.ArtifactDescription;
   import game.data.storage.artifact.ArtifactEvolutionStar;
   import game.data.storage.artifact.ArtifactLevel;
   import game.model.user.Player;
   import org.osflash.signals.Signal;
   
   public class PlayerHeroArtifact
   {
       
      
      private var _desc:ArtifactDescription;
      
      private var _slotId:uint;
      
      private var _level:uint;
      
      private var _stars:uint;
      
      private var _signal_evolve:Signal;
      
      private var _signal_levelUp:Signal;
      
      public function PlayerHeroArtifact()
      {
         _signal_evolve = new Signal();
         _signal_levelUp = new Signal();
         super();
      }
      
      public function get desc() : ArtifactDescription
      {
         return _desc;
      }
      
      public function set desc(param1:ArtifactDescription) : void
      {
         _desc = param1;
      }
      
      public function get slotId() : uint
      {
         return _slotId;
      }
      
      public function set slotId(param1:uint) : void
      {
         _slotId = param1;
      }
      
      public function get level() : uint
      {
         return _level;
      }
      
      public function set level(param1:uint) : void
      {
         _level = param1;
      }
      
      public function get maxLevel() : Boolean
      {
         return level >= desc.artifactTypeData.levels.length;
      }
      
      public function get stars() : uint
      {
         return _stars;
      }
      
      public function set stars(param1:uint) : void
      {
         _stars = param1;
      }
      
      public function get maxStars() : Boolean
      {
         return stars >= desc.artifactTypeData.evolutionStars.length;
      }
      
      public function get awakened() : Boolean
      {
         return stars > 0;
      }
      
      public function get currentLevelData() : ArtifactLevel
      {
         return desc.artifactTypeData.getLevelByLevel(level);
      }
      
      public function get nextLevelData() : ArtifactLevel
      {
         return desc.artifactTypeData.getLevelByLevel(level + 1);
      }
      
      public function get prevLevelData() : ArtifactLevel
      {
         return desc.artifactTypeData.getLevelByLevel(level - 1);
      }
      
      public function get maxLevelData() : ArtifactLevel
      {
         return desc.artifactTypeData.getLevelByLevel(desc.artifactTypeData.maxLevel);
      }
      
      public function get currentEvolutionStar() : ArtifactEvolutionStar
      {
         return desc.artifactTypeData.getEvolutionStarByStars(stars);
      }
      
      public function get nextEvolutionStar() : ArtifactEvolutionStar
      {
         return desc.artifactTypeData.getEvolutionStarByStars(stars + 1);
      }
      
      public function get maxEvolutionStar() : ArtifactEvolutionStar
      {
         return desc.artifactTypeData.getMaxEvolutionStar();
      }
      
      public function get color() : String
      {
         return currentLevelData.color;
      }
      
      public function get signal_evolve() : Signal
      {
         return _signal_evolve;
      }
      
      public function get signal_levelUp() : Signal
      {
         return _signal_levelUp;
      }
      
      public function initialize(param1:Object) : void
      {
         _level = !!param1?param1.level:1;
         _stars = !!param1?param1.star:0;
      }
      
      public function evolve() : void
      {
         stars = Math.min(stars + 1,desc.artifactTypeData.evolutionStars.length);
         signal_evolve.dispatch();
      }
      
      public function levelUp() : void
      {
         level = Math.min(level + 1,desc.artifactTypeData.levels.length);
         signal_levelUp.dispatch();
      }
      
      public function canEvolve(param1:Player, param2:PlayerHeroEntry) : Boolean
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         if(_desc.artifactTypeData.minHeroLevel <= param2.level.level)
         {
            _loc3_ = nextEvolutionStar;
            if(_loc3_)
            {
               _loc4_ = new CostData();
               _loc4_.fragmentCollection.addItem(_desc,_loc3_.costFragmentsAmount);
               _loc4_.add(_loc3_.costBase);
               if(param1.unsafeCanSpendFast(_loc4_))
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      public function canLevelUp(param1:Player, param2:PlayerHeroEntry) : Boolean
      {
         var _loc3_:* = null;
         if(_desc.artifactTypeData.minHeroLevel <= param2.level.level)
         {
            _loc3_ = nextLevelData;
            if(_loc3_ && awakened)
            {
               if(param1.canSpend(_loc3_.cost))
               {
                  return true;
               }
            }
         }
         return false;
      }
   }
}
