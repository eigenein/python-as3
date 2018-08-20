package game.mechanics.boss.storage
{
   import com.progrestar.common.lang.Translate;
   import game.data.storage.DataStorage;
   import game.data.storage.hero.HeroDescription;
   
   public class BossTypeDescription
   {
       
      
      private var _id:int;
      
      private var _heroId:int;
      
      private var _enabled:Boolean;
      
      private var _levels:Vector.<BossLevelDescription>;
      
      private var _battlegroundAsset:int;
      
      private var _mapAsset:String;
      
      private var _iconAssetTexture:String;
      
      private var _coinId:int;
      
      public const day:Vector.<int> = new Vector.<int>();
      
      public const recommendedHeroes:Vector.<HeroDescription> = new Vector.<HeroDescription>();
      
      public function BossTypeDescription(param1:Object)
      {
         var _loc2_:* = null;
         var _loc5_:int = 0;
         _levels = new Vector.<BossLevelDescription>();
         super();
         _id = param1.id;
         _heroId = param1.heroId;
         _coinId = param1.coinId;
         _enabled = param1.enabled;
         _iconAssetTexture = param1.iconAssetTexture;
         var _loc9_:int = 0;
         var _loc8_:* = param1.day;
         for each(var _loc6_ in param1.day)
         {
            this.day.push(_loc6_);
         }
         this.day.sort(sort_days);
         var _loc11_:int = 0;
         var _loc10_:* = param1.level;
         for(var _loc4_ in param1.level)
         {
            _loc2_ = param1.level[_loc4_];
            _levels.push(new BossLevelDescription(_loc2_));
         }
         _levels.sort(sort_levels);
         var _loc3_:int = _levels.length;
         _loc5_ = 0;
         while(_loc5_ < _loc3_ - 1)
         {
            _levels[_loc5_].setNextLevel(_levels[_loc5_ + 1]);
            _loc5_++;
         }
         var _loc13_:int = 0;
         var _loc12_:* = param1.recommendedHeroes;
         for each(var _loc7_ in param1.recommendedHeroes)
         {
            recommendedHeroes.push(DataStorage.hero.getHeroById(_loc7_));
         }
         _battlegroundAsset = param1.battlegroundAsset;
         _mapAsset = param1.mapAsset;
      }
      
      public static function sort_byFirstDay(param1:BossTypeDescription, param2:BossTypeDescription) : int
      {
         if(param1.day.length > 0 && param2.day.length > 0)
         {
            return param1.day[0] - param2.day[0];
         }
         return param1.day.length - param2.day.length;
      }
      
      private static function sort_days(param1:int, param2:int) : int
      {
         return param1 - param2;
      }
      
      private static function sort_levels(param1:BossLevelDescription, param2:BossLevelDescription) : int
      {
         return param1.level - param2.level;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get recommendedHeroesText() : String
      {
         return Translate.translate("LIB_BOSS_RECOMMENDEDHEROES_TEXT_" + id);
      }
      
      public function get name() : String
      {
         return Translate.translate("LIB_BOSS_NAME_" + id);
      }
      
      public function get description() : String
      {
         return Translate.translate("LIB_BOSS_DESCRIPTION_" + id);
      }
      
      public function get locationName() : String
      {
         return Translate.translate("LIB_BOSS_LOCATION_NAME_" + id);
      }
      
      public function get heroId() : int
      {
         return _heroId;
      }
      
      public function get coinId() : int
      {
         return _coinId;
      }
      
      public function get battlegroundAsset() : int
      {
         return _battlegroundAsset;
      }
      
      public function get mapAsset() : String
      {
         return _mapAsset;
      }
      
      public function get iconAssetTexture() : String
      {
         return _iconAssetTexture;
      }
      
      public function get maxLevel() : int
      {
         return _levels.length;
      }
      
      public function get enabled() : Boolean
      {
         return _enabled;
      }
      
      public function getBossEntry(param1:int) : BossLevelDescription
      {
         if(param1 < 1 || param1 > _levels.length)
         {
            return null;
         }
         return _levels[param1 - 1];
      }
      
      public function getLevel(param1:int) : BossLevelDescription
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function getLevelByBossLevel(param1:int) : BossLevelDescription
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function applyLocale() : void
      {
      }
   }
}
