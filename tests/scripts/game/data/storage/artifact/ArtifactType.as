package game.data.storage.artifact
{
   public class ArtifactType
   {
      
      public static const WEAPON:String = "weapon";
      
      public static const BOOK:String = "book";
      
      public static const RING:String = "ring";
      
      public static const SPIRIT:String = "spirit";
       
      
      private var _type:String;
      
      private var _minHeroLevel:uint;
      
      private var _levels:Vector.<ArtifactLevel>;
      
      private var _evolutionStars:Vector.<ArtifactEvolutionStar>;
      
      public function ArtifactType()
      {
         super();
      }
      
      public function get type() : String
      {
         return _type;
      }
      
      public function get minHeroLevel() : uint
      {
         return _minHeroLevel;
      }
      
      public function get levels() : Vector.<ArtifactLevel>
      {
         return _levels;
      }
      
      public function get evolutionStars() : Vector.<ArtifactEvolutionStar>
      {
         return _evolutionStars;
      }
      
      public function get maxLevel() : int
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function deserialize(param1:Object) : void
      {
         var _loc2_:* = null;
         var _loc5_:* = null;
         _type = param1.type;
         _minHeroLevel = param1.minHeroLevel;
         _levels = new Vector.<ArtifactLevel>();
         if(param1.levels)
         {
            var _loc7_:int = 0;
            var _loc6_:* = param1.levels;
            for(var _loc4_ in param1.levels)
            {
               _loc2_ = new ArtifactLevel(_loc4_);
               _loc2_.deserialize(param1.levels[_loc4_]);
               _levels.push(_loc2_);
            }
         }
         _evolutionStars = new Vector.<ArtifactEvolutionStar>();
         if(param1.evolution)
         {
            var _loc9_:int = 0;
            var _loc8_:* = param1.evolution;
            for(var _loc3_ in param1.evolution)
            {
               _loc5_ = new ArtifactEvolutionStar();
               _loc5_.deserialize(param1.evolution[_loc3_]);
               _evolutionStars.push(_loc5_);
            }
         }
      }
      
      public function getEvolutionStarByStars(param1:uint) : ArtifactEvolutionStar
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < evolutionStars.length)
         {
            if(evolutionStars[_loc2_].star == param1)
            {
               return evolutionStars[_loc2_];
            }
            _loc2_++;
         }
         return null;
      }
      
      public function getMaxEvolutionStar() : ArtifactEvolutionStar
      {
         var _loc2_:int = 0;
         var _loc1_:ArtifactEvolutionStar = null;
         _loc2_ = 0;
         while(_loc2_ < evolutionStars.length)
         {
            if(!_loc1_ || _loc1_ && _loc1_.star < evolutionStars[_loc2_].star)
            {
               _loc1_ = evolutionStars[_loc2_];
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function getLevelByLevel(param1:uint) : ArtifactLevel
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < levels.length)
         {
            if(levels[_loc2_].level == param1)
            {
               return levels[_loc2_];
            }
            _loc2_++;
         }
         return null;
      }
   }
}
