package game.data.storage.playeravatar
{
   import game.assets.storage.AssetStorage;
   import game.data.storage.DataStorage;
   import game.data.storage.DescriptionStorage;
   import game.data.storage.gear.GearItemDescription;
   import game.data.storage.hero.UnitDescription;
   import game.data.storage.skills.SkillDescription;
   import starling.textures.Texture;
   
   public class PlayerAvatarStorage extends DescriptionStorage
   {
       
      
      public function PlayerAvatarStorage()
      {
         super();
      }
      
      public function getTexture(param1:PlayerAvatarDescription) : Texture
      {
         var _loc4_:* = null;
         var _loc3_:* = null;
         var _loc2_:* = null;
         if(param1)
         {
            var _loc5_:* = param1.assetType;
            if("titan_icon" !== _loc5_)
            {
               if("hero_icon" !== _loc5_)
               {
                  if("gear" !== _loc5_)
                  {
                     if("hero" !== _loc5_)
                     {
                        if("skill" === _loc5_)
                        {
                           _loc2_ = DataStorage.skill.getById(int(param1.assetOwnerId)) as SkillDescription;
                           return AssetStorage.skillIcon.getItemTexture(_loc2_);
                        }
                     }
                     else
                     {
                        _loc3_ = DataStorage.hero.getUnitById(int(param1.assetOwnerId));
                        return AssetStorage.inventory.getUnitSquareTexture(_loc3_);
                     }
                  }
                  else
                  {
                     _loc4_ = DataStorage.gear.getById(int(param1.assetOwnerId)) as GearItemDescription;
                     return AssetStorage.inventory.getItemTexture(_loc4_);
                  }
               }
               else
               {
                  return AssetStorage.inventory.getTexture(2,param1.assetOwnerId);
               }
            }
            else
            {
               return AssetStorage.rsx.titan_icons.getTexture(param1.assetOwnerId);
            }
         }
         return AssetStorage.rsx.popup_theme.getTexture("Friend");
      }
      
      public function getTextureBackground(param1:PlayerAvatarDescription) : Texture
      {
         return AssetStorage.rsx.popup_theme.getTexture("bg_hero_" + param1.color.ident);
      }
      
      public function getVisibleList() : Vector.<PlayerAvatarDescription>
      {
         var _loc2_:Vector.<PlayerAvatarDescription> = new Vector.<PlayerAvatarDescription>();
         var _loc4_:int = 0;
         var _loc3_:* = _items;
         for each(var _loc1_ in _items)
         {
            if(!_loc1_.hidden)
            {
               _loc2_.push(_loc1_);
            }
         }
         return _loc2_;
      }
      
      public function getHiddenList() : Vector.<PlayerAvatarDescription>
      {
         var _loc2_:Vector.<PlayerAvatarDescription> = new Vector.<PlayerAvatarDescription>();
         var _loc4_:int = 0;
         var _loc3_:* = _items;
         for each(var _loc1_ in _items)
         {
            if(_loc1_.hidden)
            {
               _loc2_.push(_loc1_);
            }
         }
         return _loc2_;
      }
      
      override public function applyLocale() : void
      {
         super.applyLocale();
         var _loc3_:int = 0;
         var _loc2_:* = _items;
         for each(var _loc1_ in _items)
         {
            if(_loc1_.unlockCondition != null)
            {
               _loc1_.taskDescription = DataStorage.quest.translation.translateCondition(_loc1_.unlockCondition,_loc1_.translationMethod);
            }
            else
            {
               _loc1_.taskDescription = "";
            }
         }
      }
      
      public function getAvatarById(param1:int) : PlayerAvatarDescription
      {
         return _items[param1] as PlayerAvatarDescription;
      }
      
      override protected function parseItem(param1:Object) : void
      {
         var _loc2_:PlayerAvatarDescription = new PlayerAvatarDescription(param1);
         _items[_loc2_.id] = _loc2_;
      }
   }
}
