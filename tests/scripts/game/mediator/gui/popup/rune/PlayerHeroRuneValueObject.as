package game.mediator.gui.popup.rune
{
   import engine.core.clipgui.ClipSprite;
   import game.assets.storage.AssetStorage;
   import game.data.storage.DataStorage;
   import game.data.storage.enum.lib.HeroColor;
   import game.data.storage.rune.RuneTierDescription;
   import game.data.storage.rune.RuneTypeDescription;
   import game.model.user.hero.PlayerHeroEntry;
   import idv.cjcat.signals.Signal;
   
   public class PlayerHeroRuneValueObject
   {
       
      
      private var _hero:PlayerHeroEntry;
      
      private var _tier:RuneTierDescription;
      
      private var _type:RuneTypeDescription;
      
      public const signal_select:Signal = new Signal(PlayerHeroRuneValueObject);
      
      public function PlayerHeroRuneValueObject(param1:PlayerHeroEntry, param2:int, param3:RuneTypeDescription)
      {
         super();
         _hero = param1;
         _tier = DataStorage.rune.getTier(param2);
         _type = param3;
      }
      
      public function get level() : int
      {
         return _hero.runes.getRuneLevel(_tier.id);
      }
      
      public function get maxLevel() : int
      {
         return _hero.runes.getMaxLevel(_tier.id);
      }
      
      public function get levelCap() : int
      {
         return DataStorage.rune.getMaxLevelByHeroLevel(_hero.level.level);
      }
      
      public function get locked() : Boolean
      {
         return _hero.color.color.id < _tier.color.id;
      }
      
      public function get currentValue() : int
      {
         return _hero.runes.getRuneEnchantment(_tier.id);
      }
      
      public function get nextLevelValue() : int
      {
         return _hero.runes.getRuneNextLevelEnchantment(_tier.id);
      }
      
      public function get nextHeroLevel() : int
      {
         return DataStorage.rune.getLevel(level + 1).heroLevel;
      }
      
      public function get levelValue() : int
      {
         return _hero.runes.getRuneLevelEnchantment(_tier.id);
      }
      
      public function get tier() : int
      {
         return _tier.id;
      }
      
      public function get color() : HeroColor
      {
         return _tier.color;
      }
      
      public function get type() : RuneTypeDescription
      {
         return _type;
      }
      
      public function createIconSprite() : ClipSprite
      {
         var _loc1_:ClipSprite = new ClipSprite();
         if(_type.stat != "lifesteal")
         {
            AssetStorage.rsx.rune_icons.initGuiClip(_loc1_,_type.stat);
         }
         return _loc1_;
      }
      
      public function createIconSpriteSmall() : ClipSprite
      {
         var _loc1_:ClipSprite = new ClipSprite();
         AssetStorage.rsx.rune_icons.initGuiClip(_loc1_,_type.stat + "_small");
         return _loc1_;
      }
   }
}
