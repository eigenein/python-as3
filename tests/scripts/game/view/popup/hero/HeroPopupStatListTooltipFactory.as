package game.view.popup.hero
{
   import battle.BattleCore;
   import com.progrestar.common.lang.Translate;
   import game.mediator.gui.popup.hero.BattleStatValueObject;
   import game.mediator.gui.tooltip.TooltipVO;
   import game.view.gui.components.tooltip.TooltipTextView;
   import ru.crazybit.socexp.view.core.text.ColorUtils;
   
   public class HeroPopupStatListTooltipFactory
   {
      
      private static const mainToPa:int = 1;
      
      private static const intToMp:int = 3;
      
      private static const intToMr:int = 1;
      
      private static const agiToPa:int = 2;
      
      private static const agiToArmor:int = 1;
      
      private static const strToHp:int = 40;
      
      private static const armorScaleFactor:int = BattleCore.ARMOR_SCALE_FACTOR;
       
      
      public function HeroPopupStatListTooltipFactory()
      {
         super();
      }
      
      public function hasTooltip(param1:BattleStatValueObject) : Boolean
      {
         return Translate.has(param1.descriptionLocaleKey);
      }
      
      public function createTooltip(param1:BattleStatValueObject) : TooltipVO
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc4_:String = param1.descriptionLocaleKey;
         var _loc5_:* = param1.ident;
         if("intelligence" !== _loc5_)
         {
            if("agility" !== _loc5_)
            {
               if("strength" !== _loc5_)
               {
                  if("hp" !== _loc5_)
                  {
                     if("physicalAttack" !== _loc5_)
                     {
                        if("magicPower" !== _loc5_)
                        {
                           if("armor" !== _loc5_)
                           {
                              if("magicResist" !== _loc5_)
                              {
                                 if("lifesteal" !== _loc5_)
                                 {
                                    if("armorPenetration" !== _loc5_)
                                    {
                                       if("magicPenetration" !== _loc5_)
                                       {
                                          if("dodge" !== _loc5_)
                                          {
                                             if("physicalCritChance" !== _loc5_)
                                             {
                                             }
                                             addr72:
                                             _loc2_ = Translate.translateArgs(_loc4_);
                                          }
                                          §§goto(addr72);
                                       }
                                    }
                                    addr61:
                                    _loc2_ = Translate.translateArgs(_loc4_,param1.statValue);
                                 }
                                 §§goto(addr61);
                              }
                           }
                           addr47:
                           _loc2_ = Translate.translateArgs(_loc4_,int(armorScaleFactor / 3),armorScaleFactor);
                        }
                        addr46:
                        §§goto(addr47);
                     }
                     addr45:
                     §§goto(addr46);
                  }
                  §§goto(addr45);
               }
               else
               {
                  _loc2_ = Translate.translateArgs(_loc4_,40,1);
               }
            }
            else
            {
               _loc2_ = Translate.translateArgs(_loc4_,1,2,1);
            }
         }
         else
         {
            _loc2_ = Translate.translateArgs(_loc4_,3,1,1);
         }
         if(_loc2_)
         {
            _loc2_ = _loc2_.replace(/\[/g,ColorUtils.hexToRGBFormat(16645626));
            _loc2_ = ColorUtils.hexToRGBFormat(16573879) + _loc2_.replace(/\]/g,ColorUtils.hexToRGBFormat(16573879));
            _loc3_ = new TooltipVO(TooltipTextView,_loc2_);
            return _loc3_;
         }
         return null;
      }
   }
}
