package game.model.user.settings
{
   public class PlayerSettingsData
   {
       
      
      public const playSounds:PlayerSettingsParameter = new PlayerSettingsParameter("sounds",Boolean,true);
      
      public const playMusic:PlayerSettingsParameter = new PlayerSettingsParameter("music",Boolean,true);
      
      public const screenShake:PlayerSettingsParameter = new PlayerSettingsParameter("screenShake",Number,1);
      
      public const showSkillDetails:PlayerSettingsParameter = new PlayerSettingsParameter("skillDetails",Boolean,false);
      
      public const showProfileToClanMembers:PlayerSettingsParameter = new PlayerSettingsParameter("showProfile",Boolean,false);
      
      public const foulLanguageFilter:PlayerSettingsParameter = new PlayerSettingsParameter("foulLanguageFilter",Boolean,true);
      
      public const soundsVolume:PlayerSettingsParameter = new PlayerSettingsParameter("soundsVolume",Number,1);
      
      public const musicVolume:PlayerSettingsParameter = new PlayerSettingsParameter("musicVolume",Number,1);
      
      public const socialGroupPromotion:PlayerSettingsParameter = new PlayerSettingsParameter("socialGroupPromotion",String,null);
      
      public function PlayerSettingsData()
      {
         super();
      }
      
      public function init(param1:Object) : void
      {
         playSounds.syncronizeFromObject(param1);
         playMusic.syncronizeFromObject(param1);
         showSkillDetails.syncronizeFromObject(param1);
         showProfileToClanMembers.syncronizeFromObject(param1);
         soundsVolume.syncronizeFromObject(param1);
         musicVolume.syncronizeFromObject(param1);
         screenShake.syncronizeFromObject(param1);
         socialGroupPromotion.syncronizeFromObject(param1);
         foulLanguageFilter.syncronizeFromObject(param1);
      }
      
      public function syncronizeParameter(param1:PlayerSettingsParameter, param2:*) : void
      {
         param1.syncronize(param2);
      }
   }
}
