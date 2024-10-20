String jsonString = '''
  [
    {
      "Exercise_Name": "Rickshaw Carry",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/742/Male/m/742_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/742/Male/m/742_2.jpg"
    },
    {
      "Exercise_Name": "Single-Leg Press",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-50m-single-leg-leg-press-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-50m-single-leg-leg-press-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Landmine twist",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-129s-landmine-twist-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-129s-landmine-twist-m3-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Weighted pull-up",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-96c-weighted-pull-up-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-96c-weighted-pull-up-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "T-Bar Row with Handle",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/1931/Male/m/1931_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/october/1931_2sm.jpg"
    },
    {
      "Exercise_Name": "Palms-down wrist curl over bench",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-62e-palms-down-wrist-curl-over-bench-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-62e-palms-down-wrist-curl-over-bench-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Atlas Stones",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/659/Male/m/659_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/659/Male/m/659_2.jpg"
    },
    {
      "Exercise_Name": "Dumbbell front raise to lateral raise",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-61d-dumbbell-front-raise-to-lateral-raise-m2-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-61d-dumbbell-front-raise-to-lateral-raise-m3-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Incline Hammer Curls",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/882/Male/m/882_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/882/Male/m/882_2.jpg"
    },
    {
      "Exercise_Name": "Straight-bar wrist roll-up",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-116s-straight-bar-wrist-roll-up-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-116s-straight-bar-wrist-roll-up-m3-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Barbell glute bridge",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-114s-barbell-glute-bridge-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-114s-barbell-glute-bridge-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Clean and press",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-27b-clean-and-press-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-27b-clean-and-press-m5-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Triceps dip",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-1m-triceps-dip-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-1m-triceps-dip-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Dumbbell farmer's walk",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-30d-dumbbell-farmers-walk-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-30d-dumbbell-farmers-walk-m5-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Palms-up wrist curl over bench",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2F14121101-Barbell-Palms-Up-Wrist-Curl-Over-A-Bench_Forearms_small.png?alt=media&token=bc4263d4-1108-48ae-a800-15ec96b27b27",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Barbell Full Squat",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FBarbell%20Full%20Squat.jpeg?alt=media&token=5c8dfdc4-9054-4384-9496-10c6b1f14233",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Barbell deficit deadlift",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FBarbell%20deficit%20deadlift.jpeg?alt=media&token=ea3f44f2-68f2-47a8-8dfc-bc1a4e0c000e",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Barbell Deadlift",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FBarbell-Deadlift-1.png?alt=media&token=8835091d-fcde-4ea0-81a3-d10b9587f1d3",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Single-arm palm-in dumbbell shoulder press",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FSingle-arm%20palm-in%20dumbbell%20shoulder%20press.jpeg?alt=media&token=e486ebff-eb3c-42cd-ab93-95dd43f65332",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Romanian Deadlift With Dumbbells",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FRomanian%20Deadlift%20With%20Dumbbells.jpg?alt=media&token=4ea8dc86-a59b-4f40-9f6c-587ddeab8955",
      "Exercise_Image1": ""
    },
    {"Exercise_Name": "Tire flip", "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FTire%20flip.jpg?alt=media&token=b82de1ff-4332-4c24-bbcd-e662a731445b", "Exercise_Image1": ""},
    {
      "Exercise_Name": "Clean Deadlift",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FClean%20Deadlift.jpg?alt=media&token=c866fcab-1c73-4be0-93ad-41c27c10adb5",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Elbow plank",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FElbow%20plank.jpeg?alt=media&token=9b7eed59-77a9-4c31-958c-37446a137675",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Bottoms Up",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-63a-lying-leg-lift-m2-square-600x600.jpg",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Barbell back squat to box",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-72e-barbell-back-squat-to-box-m2-square-600x600.jpg",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Clean and jerk",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-26b-clean-and-jerk-m1-square-600x600.jpg",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Single-arm kettlebell push-press",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-67k-single-arm-kettlebell-push-press-m2-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-67k-single-arm-kettlebell-push-press-m3-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Push-press",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-39b-push-press-m2-square-600x600.jpg",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Suspended ab fall-out",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/2019-xdb-158s-suspended-ab-fall-out-m2-600x600.jpg",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Reverse Band Box Squat",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/753/Male/m/753_2.jpg",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Standing palms-in shoulder press",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FStanding%20palms-in%20shoulder%20press.jpg?alt=media&token=a5319dfc-ff6d-4657-8d61-1b79c0fdad5e",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Standing cable low-to-high twist",
      "Exercise_Image": "https://firebasestorage.googleapis.com/v0/b/ironfit-edef8.appspot.com/o/exersices_imgs%2FStanding%20cable%20low-to-high%20twist.jpg?alt=media&token=294c0955-1414-467d-8147-00a916f433a5",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Decline EZ-bar skullcrusher",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-47n-decline-ez-bar-skullcrusher-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-47n-decline-ez-bar-skullcrusher-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Standing behind-the-back wrist curl",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-14b-standing-behind-the-back-wrist-curl-m1-square-600x600.jpg",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Seated finger curl",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Wide-grip barbell curl",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Dumbbell spell caster",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Dumbbell floor press",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Lying Face Down Plate Neck Resistance",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {"Exercise_Name": "Pullups", "Exercise_Image": "", "Exercise_Image1": ""},
    {
      "Exercise_Name": "Dumbbell Bench Press",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Jumping rope",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Seated barbell shoulder press",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "EZ-bar spider curl",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-18n-barbell-spider-curl-m1-square-600x600.jpg",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Smith machine shrug",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Smith Machine Calf Raise",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Romanian Deadlift from Deficit",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Power Snatch",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {"Exercise_Name": "Pushups", "Exercise_Image": "", "Exercise_Image1": ""},
    {
      "Exercise_Name": "Barbell walking lunge",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Front Squats With Two Kettlebells",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/511/Male/m/511_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/511/Male/m/511_2.jpg"
    },
    {
      "Exercise_Name": "Spider crawl",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Power Clean from Blocks",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Seated Two-Arm Palms-Up Low-Pulley Wrist Curl",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Hammer Curls",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-7d-hammer-curl-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-7d-hammer-curl-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Incline dumbbell bench press",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-3n-incline-dumbbell-bench-press-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-3n-incline-dumbbell-bench-press-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Low-cable cross-over",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-5c-low-cable-cross-over-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-5c-low-cable-cross-over-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Single-arm high-cable side bend",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/2019-xdb-107c-single-arm-high-cable-side-bend-m1-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/2019-xdb-107c-single-arm-high-cable-side-bend-m2-600x600.jpg"
    },
    {
      "Exercise_Name": "Single Leg Push-off",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/818/Male/m/818_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/818/Male/m/818_2.jpg"
    },
    {
      "Exercise_Name": "Hip Circles (Prone)",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/may/874_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/may/874_2.jpg"
    },
    {
      "Exercise_Name": "Reverse-grip bent-over row",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-02b-reverse-grip-bent-over-row-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-02b-reverse-grip-bent-over-row-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Back extension",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-16m-back-extension-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-16m-back-extension-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Close-grip bench press",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-82e-close-grip-bench-press-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-82e-close-grip-bench-press-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Cocoons",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-170a-cocoon-crunch-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-170a-cocoon-crunch-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Cross-Body Crunch",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-176a-elbow-to-knee-crunch-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-176a-elbow-to-knee-crunch-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Dumbbell Flyes",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-31e-dumbbell-chest-fly-m1-square-600x600.jpg",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Seated Dumbbell Press",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-50e-seated-dumbbell-shoulder-press-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-50e-seated-dumbbell-shoulder-press-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Standing dumbbell shoulder press",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-104d-standing-dumbbell-shoulder-press-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-104d-standing-dumbbell-shoulder-press-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "EZ-Bar Curl",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/2020-xdb-46s-standing-ez-bar-curl-m1-crop-600x600.jpg",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Olympic Squat",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Natural Glute Ham Raise",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Axle Deadlift",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Zottman Curl",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Glute ham raise-",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Single-arm lateral raise",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Power Partials",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Leverage Shrug",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/898/Male/m/898_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/898_2.jpg"
    },
    {
      "Exercise_Name": "Cable V-bar push-down",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-17c-cable-v-bar-push-down-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-17c-cable-v-bar-push-down-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Wrist Roller",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/142/Male/m/142_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/142/Male/m/142_2.jpg"
    },
    {
      "Exercise_Name": "Incline dumbbell reverse fly",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/2020-xdb-13n-incline-dumbbell-reverse-fly-m1-crop-600x600.jpg",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Stair climber",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Elbow-to-knee crunch",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-176a-elbow-to-knee-crunch-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-176a-elbow-to-knee-crunch-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Kettlebell Pistol Squat",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/521/Male/m/521_2.jpg",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Overhead dumbbell front raise",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-17d-overhead-dumbbell-front-raise-m1-square-600x600.jpg",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Biceps curl to shoulder press",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Weighted bench dip",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Barbell Hip Thrust",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Forward lunge",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Barbell Bench Press - Medium Grip",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {"Exercise_Name": "Chest dip", "Exercise_Image": "", "Exercise_Image1": ""},
    {
      "Exercise_Name": "Seated dumbbell shoulder press",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-50e-seated-dumbbell-shoulder-press-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-50e-seated-dumbbell-shoulder-press-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Barbell Curl",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "EZ-Bar Skullcrusher",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-94s-ez-bar-skullcrusher-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-94s-ez-bar-skullcrusher-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "One-Arm Dumbbell Row",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-13e-single-arm-bench-dumbbell-row-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-13e-single-arm-bench-dumbbell-row-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Alternating standing shoulder press",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-93d-alternating-standing-shoulder-press-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-93d-alternating-standing-shoulder-press-m3-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Concentration curl",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-8e-concentration-curl-m1-square-600x600.jpg",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Decline Crunch",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Decline Dumbbell Flyes",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-31n-decline-dumbbell-chest-fly-m2-square-600x600.jpg",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Single-arm incline rear delt raise",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Alternating dumbbell front raise",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Hanging toes-to-bar",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Narrow-stance squat",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Kneeling cable oblique crunch",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Reverse Grip Triceps Pushdown",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-19c-reverse-grip-cable-straight-bar-push-down-m2-square-600x600.jpg",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Bear crawl sled drag",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Thigh adductor",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Machine Bicep Curl",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/899/Male/m/899_2.jpg",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Seated Palms-Down Barbell Wrist Curl",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/389/Male/m/389_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/389/Male/m/389_2.jpg"
    },
    {
      "Exercise_Name": "Single-arm incline rear delt raise",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-14n-single-arm-incline-rear-delt-raise-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-14n-single-arm-incline-rear-delt-raise-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Alternating dumbbell front raise",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-14d-alternating-dumbbell-front-raise-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-14d-alternating-dumbbell-front-raise-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Hanging toes-to-bar",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/2019-xdb-128c-hanging-toes-to-bar-m1-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/2019-xdb-128c-hanging-toes-to-bar-m2-600x600.jpg"
    },
    {
      "Exercise_Name": "Narrow-stance squat",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-30a-narrow-stance-squat-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-30a-narrow-stance-squat-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Kneeling cable oblique crunch",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-36c-kneeling-cable-oblique-crunch-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-36c-kneeling-cable-oblique-crunch-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Reverse Grip Triceps Pushdown",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-19c-reverse-grip-cable-straight-bar-push-down-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-19c-reverse-grip-cable-straight-bar-push-down-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Bear crawl sled drag",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/2020-xdb-153s-bear-crawl-sled-drag-m1-crop-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/2020-xdb-153s-bear-crawl-sled-drag-m4-crop-600x600.jpg"
    },
    {
      "Exercise_Name": "Rocky Pull-Ups/Pulldowns",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/279/Male/m/279_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/279/Male/m/279_2.jpg"
    },
    {
      "Exercise_Name": "Snatch-Grip Behind-The-Neck Overhead Press",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Box Squat with Bands",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Flexor Incline Dumbbell Curls",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Seated One-Arm Dumbbell Palms-Up Wrist Curl",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Machine Bicep Curl",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Car driver",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Alternating Deltoid Raise",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Hanging Oblique Knee Raise",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/2019-xdb-120c-hanging-oblique-crunch-m1-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/2019-xdb-120c-hanging-oblique-crunch-m2-600x600.jpg"
    },
    {
      "Exercise_Name": "Bodyweight Flyes",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/2019-xdb-182s-double-bar-roll-out-chest-fly-m1-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/2019-xdb-182s-double-bar-roll-out-chest-fly-m2-600x600.jpg"
    },
    {
      "Exercise_Name": "Standing Calf Raises",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-117s-standing-calf-raise-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-117s-standing-calf-raise-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Push-Ups - Close Triceps Position",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-104a-close-push-up-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-104a-close-push-up-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "One-Arm Long Bar Row",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-124s-single-arm-landmine-bent-over-row-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-124s-single-arm-landmine-bent-over-row-m3-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Overhead cable curl",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Single-dumbbell front raise",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-18d-single-dumbbell-front-raise-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-18d-single-dumbbell-front-raise-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Incline cable chest fly",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-10c-incline-cable-chest-fly-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-10c-incline-cable-chest-fly-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Single-leg depth squat",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-68e-single-leg-depth-squat-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-68e-single-leg-depth-squat-m4-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Dumbbell suitcase crunch",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-50d-dumbbell-suitcase-crunch-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-50d-dumbbell-suitcase-crunch-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Plate Twist",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/106/Male/m/106_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/106/Male/m/106_2.jpg"
    },
    {
      "Exercise_Name": "Single-leg cable hip extension",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-43c-single-leg-cable-hip-extension-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-43c-single-leg-cable-hip-extension-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Weighted Jump Squat",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/887/Male/m/887_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/887/Male/m/887_2.jpg"
    },
    {
      "Exercise_Name": "Squat with Chains",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Gorilla Chin/Crunch",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Kneeling cable triceps extension",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Kneeling Cable Crunch With Alternating Oblique Twists",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {"Exercise_Name": "Bicycling", "Exercise_Image": "", "Exercise_Image1": ""},
    {
      "Exercise_Name": "Arnold press",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Weighted Crunches",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-50d-dumbbell-suitcase-crunch-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-50d-dumbbell-suitcase-crunch-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Single-arm cable triceps extension",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-31c-single-arm-cable-triceps-extension-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-31c-single-arm-cable-triceps-extension-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Barbell roll-out",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-48b-barbell-roll-out-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-48b-barbell-roll-out-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Kneeling cable crunch",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-35c-kneeling-cable-crunch-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-35c-kneeling-cable-crunch-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Exercise Ball Pull-In",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Hanging leg raise",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-9m-hanging-leg-raise-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-9m-hanging-leg-raise-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Barbell Ab Rollout - On Knees",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-48b-barbell-roll-out-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-48b-barbell-roll-out-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Barbell Squat",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-50b-barbell-back-squat-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-50b-barbell-back-squat-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Decline barbell bench press",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-34n-decline-barbell-bench-press-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-34n-decline-barbell-bench-press-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Dumbbell Bicep Curl",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Dumbbell Goblet Squat",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Dumbbell squat",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Barbell front squat",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-51b-barbell-front-squat-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-51b-barbell-front-squat-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Close-grip pull-down",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Triceps Pushdown - Rope Attachment",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Side-to-side box skip",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-69e-side-to-side-box-skip-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-69e-side-to-side-box-skip-m3-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Smith machine shoulder press",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-alt-31t-smith-machine-shoulder-press-m1-square-600x600.jpg",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Seated triceps press",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Dumbbell Lying Supination",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Pull-up",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-92c-pull-up-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-92c-pull-up-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Wide-grip bench press",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-84e-wide-grip-bench-press-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-84e-wide-grip-bench-press-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Close-grip EZ-bar curl",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-47s-close-grip-ez-bar-curl-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-47s-close-grip-ez-bar-curl-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "T-Bar Row",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/3381_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/3381_2.jpg"
    },
    {
      "Exercise_Name": "Bent Over Two-Arm Long Bar Row",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/18/Male/m/18_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/18/Male/m/18_2.jpg"
    },
    {"Exercise_Name": "Muscle Up", "Exercise_Image": "", "Exercise_Image1": ""},
    {
      "Exercise_Name": "Machine shoulder press",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Incline EZ-bar skullcrusher",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Alternating sit-through with crunch",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-124s-single-arm-landmine-bent-over-row-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-124s-single-arm-landmine-bent-over-row-m3-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Wide-Grip Decline Barbell Bench Press",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {"Exercise_Name": "Rower", "Exercise_Image": "", "Exercise_Image1": ""},
    {
      "Exercise_Name": "Snatch Deadlift",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Front Plate Raise",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Decline Close-Grip Bench To Skull Crusher",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/288/Male/m/288_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/288/Male/m/288_2.jpg"
    },
    {
      "Exercise_Name": "Lying Leg Curls",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-20m-lying-leg-curl-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-20m-lying-leg-curl-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Cross-body hammer curl",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-4d-cross-body-hammer-curl-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-4d-cross-body-hammer-curl-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Shotgun row",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-37c-shotgun-row-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-37c-shotgun-row-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Ab Roller",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-2s-ab-wheel-roll-out-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-2s-ab-wheel-roll-out-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Reverse-grip incline dumbbell bench press",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-4n-reverse-grip-incline-dumbbell-bench-press-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-4n-reverse-grip-incline-dumbbell-bench-press-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Leg Press",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-44m-leg-press-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-44m-leg-press-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Stiff-Legged Dumbbell Deadlift",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-9d-dumbbell-stiff-legged-deadlift-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-9d-dumbbell-stiff-legged-deadlift-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Cable Crossover",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Barbell Incline Bench Press Medium-Grip",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Incline Dumbbell Flyes",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Seated Cable Rows",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Tricep Dumbbell Kickback",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-76d-single-arm-triceps-kick-back-m2-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-76d-single-arm-triceps-kick-back-m3-square-600x600.jpg"
    },
    {"Exercise_Name": "Otis-Up", "Exercise_Image": "", "Exercise_Image1": ""},
    {
      "Exercise_Name": "Mountain climber",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-201a-mountain-climber-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-201a-mountain-climber-m3-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Ab bicycle",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-73a-ab-cycle-m2-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-73a-ab-cycle-m3-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Barbell forward lunge",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-43b-barbell-forward-lunge-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-43b-barbell-forward-lunge-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "3/4 sit-up",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-149a-34-sit-up-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-149a-34-sit-up-m3-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Exercise ball leg curl",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-21s-exercise-ball-leg-curl-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-21s-exercise-ball-leg-curl-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Glute bridge",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-59a-glute-bridge-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-59a-glute-bridge-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Close-Grip Front Lat Pulldown",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-73c-close-grip-pull-down-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-73c-close-grip-pull-down-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Dip Machine",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/146/Male/m/146_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/146/Male/m/146_2.jpg"
    },
    {
      "Exercise_Name": "Incline dumbbell row",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Dumbbell Lunges",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Single-arm standing shoulder press",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Preacher Curl",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-55s-ez-bar-preacher-curl-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-55s-ez-bar-preacher-curl-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Reverse crunch",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/2019-xdb-263a-reverse-crunch-m1-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/2019-xdb-263a-reverse-crunch-m2-600x600.jpg"
    },
    {
      "Exercise_Name": "Standing Dumbbell Triceps Extension",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/june/345_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/june/345_2.jpg"
    },
    {
      "Exercise_Name": "Elliptical trainer",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-22m-elliptical-trainer-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-22m-elliptical-trainer-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Bodyweight squat",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-27a-bodyweight-squat-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-27a-bodyweight-squat-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Bent Over Two-Dumbbell Row With Palms In",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/17/Male/m/17_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/17/Male/m/17_2.jpg"
    },
    {
      "Exercise_Name": "Hex-bar deadlift",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-123s-hex-bar-deadlift-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-123s-hex-bar-deadlift-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Narrow-stance leg press",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-46m-wide-stance-leg-press-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-46m-wide-stance-leg-press-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Single-leg glute bridge",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-61a-single-leg-glute-bridge-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-61a-single-leg-glute-bridge-m3-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Barbell Curls Lying Against An Incline",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/300/Male/m/300_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/300/Male/m/300_2.jpg"
    },
    {
      "Exercise_Name": "Standing Hip Circles",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/873/Male/m/873_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/873/Male/m/873_2.jpg"
    },
    {
      "Exercise_Name": "Clam",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/april/2843_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/april/2843_2.jpg"
    },
    {
      "Exercise_Name": "Narrow Stance Hack Squats",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Seated Close-Grip Concentration Barbell Curl",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Dumbbell Lying Pronation",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Smith machine box squat",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {"Exercise_Name": "Drop Push", "Exercise_Image": "", "Exercise_Image1": ""},
    {
      "Exercise_Name": "Upside-down pull-up",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Reverse Barbell Preacher Curls",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Close-grip EZ-bar bench press",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Incline Push-Up",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Hyperextensions With No Hyperextension Bench",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Dumbbell front raise",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-13d-dumbbell-front-raise-m2-square-600x600.jpg",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Parallel Bar Dip",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-1m-triceps-dip-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-1m-triceps-dip-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Stairmaster",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-51m-stair-climber-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-51m-stair-climber-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Double Leg Butt Kick",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/778/Male/m/778_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/778/Male/m/778_2.jpg"
    },
    {"Exercise_Name": "Groiners", "Exercise_Image": "", "Exercise_Image1": ""},
    {
      "Exercise_Name": "Neck Press",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Broad jump",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Machine Squat",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "V-bar pull-up",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/2020-xdb-140c-v-bar-pull-up-m1-crop-600x600.jpg",
      "Exercise_Image1": ""
    },
    {"Exercise_Name": "Ring dip", "Exercise_Image": "", "Exercise_Image1": ""},
    {
      "Exercise_Name": "Standing One-Arm Cable Curl",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Burpee",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-38a-burpee-m4-square-600x600.jpg",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Double-arm triceps kick-back",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-75d-double-arm-triceps-kick-back-m2-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-75d-double-arm-triceps-kick-back-m3-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Dumbbell reverse lunge",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-83d-dumbbell-reverse-lunge-m1-square-600x600.jpg",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Seated Calf Raise",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-13m-machine-seated-calf-raise-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-13m-machine-seated-calf-raise-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Standing dumbbell shrug",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-115d-standing-dumbbell-shrug-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-115d-standing-dumbbell-shrug-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Barbell step-up",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Feet-elevated bench dip",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Bent Over Barbell Row",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Dumbbell Alternate Bicep Curl",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Bent-over dumbbell rear delt row",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "External Rotation with Cable",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Handstand push-up",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Single-arm dumbbell preacher curl",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-53s-single-arm-dumbbell-preacher-curl-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-53s-single-arm-dumbbell-preacher-curl-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Step-up with knee raise",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-70e-step-up-with-knee-raise-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-70e-step-up-with-knee-raise-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Smith machine back squat",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-18t-smith-machine-back-squat-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-18t-smith-machine-back-squat-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Alternate Incline Dumbbell Curl",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-26n-alternating-incline-dumbbell-biceps-curl-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-26n-alternating-incline-dumbbell-biceps-curl-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Standing dumbbell upright row",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-125d-standing-dumbbell-upright-row-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-125d-standing-dumbbell-upright-row-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Single-arm cable front raise",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-42c-single-arm-cable-front-raise-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-42c-single-arm-cable-front-raise-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Two-Arm Kettlebell Military Press",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/530/Male/m/530_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/530/Male/m/530_2.jpg"
    },
    {
      "Exercise_Name": "Incline cable chest press",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-11c-incline-cable-chest-press-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-11c-incline-cable-chest-press-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Step-up with knee raise",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-70e-step-up-with-knee-raise-m2-square-600x600.jpg",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Incline dumbbell front raise",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-11n-incline-dumbbell-front-raise-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-11n-incline-dumbbell-front-raise-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Rope climb",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-155s-rope-climb-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-155s-rope-climb-m3-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Trail Running/Walking",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Standing Bradford press",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Neutral-grip dumbbell bench press",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Cable Chest Press",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/870/Male/m/870_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/870/Male/m/870_2.jpg"
    },
    {
      "Exercise_Name": "Standing concentration curl",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-23d-standing-concentration-curl-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-23d-standing-concentration-curl-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Wide-Grip Rear Pull-Up",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/191/Male/m/191_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/191/Male/m/191_2.jpg"
    },
    {
      "Exercise_Name": "Kettlebell pass-through lunge",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-57k-kettlebell-pass-through-lunge-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-57k-kettlebell-pass-through-lunge-m4-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Hands-elevated push-up",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-18e-hands-elevated-push-up-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-18e-hands-elevated-push-up-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Deadlift with Bands",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/677/Male/m/677_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/677/Male/m/677_2.jpg"
    },
    {
      "Exercise_Name": "Straight-arm rope pull-down",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/2019-xdb-105c-straight-arm-rope-pull-down-m1-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/2019-xdb-105c-straight-arm-rope-pull-down-m2-600x600.jpg"
    },
    {
      "Exercise_Name": "Barbell Shoulder Press",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-48e-seated-barbell-shoulder-press-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-48e-seated-barbell-shoulder-press-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Power clean",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-25b-power-clean-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-25b-power-clean-m4-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Hang Snatch",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/690/Male/m/690_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/690/Male/m/690_2.jpg"
    },
    {
      "Exercise_Name": "Kettlebell sumo deadlift high pull",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-49k-kettlebell-sumo-deadlift-high-pull-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-49k-kettlebell-sumo-deadlift-high-pull-m3-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Calf-Machine Shoulder Shrug",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/184/Male/m/184_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/184/Male/m/184_2.jpg"
    },
    {
      "Exercise_Name": "Bench Press - Powerlifting",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/663/Male/m/663_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/663/Male/m/663_2.jpg"
    },
    {
      "Exercise_Name": "Rocking Standing Calf Raise",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Goblet Squat",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Behind-the-head skullcrusher",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-56e-behind-the-head-skullcrusher-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-56e-behind-the-head-skullcrusher-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Seated palms-up wrist curl",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-65e-seated-palms-up-wrist-curl-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-65e-seated-palms-up-wrist-curl-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Reverse Cable Curl",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/141/Male/m/141_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/141/Male/m/141_2.jpg"
    },
    {
      "Exercise_Name": "Dumbbell side bend",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-102d-dumbbell-side-bend-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-102d-dumbbell-side-bend-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Lat pull-down",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-72c-lat-pull-down-m1-square-600x600.jpg",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Side Lateral Raise",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-77d-dumbbell-lateral-raise-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-77d-dumbbell-lateral-raise-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Alternating incline dumbbell biceps curl",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-26n-alternating-incline-dumbbell-biceps-curl-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-26n-alternating-incline-dumbbell-biceps-curl-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Kettlebell One-Legged Deadlift",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-4k-single-leg-kettlebell-deadlift-m1-square-600x600.jpg",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Alternate Hammer Curl",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-3d-alternating-hammer-curl-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-3d-alternating-hammer-curl-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Decline Push-Up",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-20e-feet-elevated-push-up-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-20e-feet-elevated-push-up-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Captain's chair knee raise",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-5m-captains-chair-knee-raise-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-5m-captains-chair-knee-raise-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Triceps Pushdown",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-17c-cable-v-bar-push-down-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-17c-cable-v-bar-push-down-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Low cable overhead triceps extension",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Single-arm cable cross-over",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Seated dumbbell biceps curl",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Battle ropes",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Dead bug reach",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Deadlift with Chains",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Rope Crunch",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-35c-kneeling-cable-crunch-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-35c-kneeling-cable-crunch-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Palms-Up Dumbbell Wrist Curl Over A Bench",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Kettlebell thruster",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Single-Arm Push-Up",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Band Hip Adductions",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/850/Male/m/850_2.jpg",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Single-arm kettlebell clean",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-80k-single-arm-kettlebell-clean-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-80k-single-arm-kettlebell-clean-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Preacher Hammer Dumbbell Curl",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/155/Male/m/155_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/155/Male/m/155_2.jpg"
    },
    {
      "Exercise_Name": "Alternating Kettlebell Press",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/504/Male/m/504_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/504/Male/m/504_2.jpg"
    },
    {
      "Exercise_Name": "Split Squat with Dumbbells",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-61e-dumbbell-bulgarian-split-squat-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-61e-dumbbell-bulgarian-split-squat-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Kneeling Squat",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/697/Male/m/697_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/697/Male/m/697_2.jpg"
    },
    {
      "Exercise_Name": "Close-grip barbell curl",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-20b-close-grip-barbell-curl-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-20b-close-grip-barbell-curl-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Leverage Incline Chest Press",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/893/Male/m/893_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/893/Male/m/893_2.jpg"
    },
    {
      "Exercise_Name": "Kettlebell Turkish Get-Up (Squat style)",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/527/Male/m/527_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/527/Male/m/527_2.jpg"
    },
    {
      "Exercise_Name": "Crunch - Hands Overhead",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/113/Male/m/113_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/113/Male/m/113_2.jpg"
    },
    {
      "Exercise_Name": "Cable Internal Rotation",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/315/Male/m/315_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/315/Male/m/315_2.jpg"
    },
    {
      "Exercise_Name": "Leg Extensions",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-18m-leg-extension-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-18m-leg-extension-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Standing One-Arm Dumbbell Curl Over Incline Bench",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/339/Male/m/339_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/339/Male/m/339_2.jpg"
    },
    {
      "Exercise_Name": "Standing Olympic Plate Hand Squeeze",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/6/Male/m/6_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/6/Male/m/6_2.jpg"
    },
    {
      "Exercise_Name": "Sledgehammer swing",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/2019-xdb-186s-sledghehammer-swing-m1-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/2019-xdb-186s-sledghehammer-swing-m3-600x600.jpg"
    },
    {
      "Exercise_Name": "Single-arm kettlebell snatch",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-79k-single-arm-kettlebell-snatch-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-79k-single-arm-kettlebell-snatch-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Box jump",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-75e-box-jump-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-75e-box-jump-m3-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Standing cable crunch",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-34c-standing-cable-crunch-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-34c-standing-cable-crunch-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Standing barbell overhead triceps extension",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-60b-standing-barbell-overhead-triceps-extension-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-60b-standing-barbell-overhead-triceps-extension-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Lying cable triceps extension",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-62c-lying-cable-triceps-extension-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-62c-lying-cable-triceps-extension-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Decline dumbbell bench press",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-33n-decline-dumbbell-bench-press-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-33n-decline-dumbbell-bench-press-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "V-up",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-76a-v-up-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-76a-v-up-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Barbell Bulgarian split squat",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/2020-xdb-60e-barbell-bulgarian-split-squat-m1-crop-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/2020-xdb-60e-barbell-bulgarian-split-squat-m2-crop-600x600.jpg"
    },
    {
      "Exercise_Name": "Reverse-grip lat pull-down",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-74c-reverse-grip-lat-pull-down-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-74c-reverse-grip-lat-pull-down-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Standing Biceps Cable Curl",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-22c-cable-straight-bar-biceps-curl-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-22c-cable-straight-bar-biceps-curl-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Single-arm cable seated row",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-82c-single-arm-cable-seated-row-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-82c-single-arm-cable-seated-row-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Single-arm kettlebell row",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-12e-single-arm-dumbbell-bench-press-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-12e-single-arm-dumbbell-bench-press-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Scissors Jump",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-42a-alternating-lunge-jump-m4-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-42a-alternating-lunge-jump-m5-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Wide Stance Stiff Legs",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/744/Male/m/744_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/744/Male/m/744_2.jpg"
    },
    {
      "Exercise_Name": "Rack Pull with Bands",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/741/Male/m/741_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/741/Male/m/741_2.jpg"
    },
    {
      "Exercise_Name": "Drag curl",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-11b-drag-curl-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-11b-drag-curl-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Close push-up to wide push-up",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-105a-close-push-up-to-wide-push-up-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-105a-close-push-up-to-wide-push-up-m4-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Single-arm dumbbell triceps extension",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-130d-single-arm-dumbbell-triceps-extension-m2-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-130d-single-arm-dumbbell-triceps-extension-m3-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Butterfly",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-53m-machine-chest-fly-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-53m-machine-chest-fly-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Seated face pull",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-70c-seated-face-pull-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-70c-seated-face-pull-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Hang Clean - Below the Knees",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Decline oblique crunch",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Dumbbell external shoulder rotation",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Single-arm bent-over cable rear delt fly",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-48c-single-arm-cable-rear-delt-fly-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-48c-single-arm-cable-rear-delt-fly-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Clean",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/669/Male/m/669_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/669/Male/m/669_2.jpg"
    },
    {
      "Exercise_Name": "Single-arm incline lateral raise",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-24n-single-arm-incline-lateral-raise-m1-square-600x600.jpg",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Decline bar press sit-up",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-44n-decline-press-sit-up-m1-square-600x600.jpg",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Barbell rear delt bent-over row",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-03b-barbell-rear-delt-bent-over-row-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-03b-barbell-rear-delt-bent-over-row-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Calf Press",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-117s-standing-calf-raise-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-117s-standing-calf-raise-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Kettlebell alternating renegade row",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-11k-kettlebell-alternating-renegade-row-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-11k-kettlebell-alternating-renegade-row-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Bosu Ball Cable Crunch With Side Bends",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/932/Male/m/932_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/932/Male/m/932_2.jpg"
    },
    {
      "Exercise_Name": "Stomach Vacuum",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/243/Male/m/243_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/243/Male/m/243_2.jpg"
    },
    {
      "Exercise_Name": "Hammer Grip Incline DB Bench Press",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/60/Male/m/60_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/60/Male/m/60_2.jpg"
    },
    {
      "Exercise_Name": "Wide-grip hands-elevated push-up",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-19e-wide-grip-hands-elevated-push-up-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-19e-wide-grip-hands-elevated-push-up-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Decline Dumbbell Triceps Extension",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/167/Male/m/167_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/167/Male/m/167_2.jpg"
    },
    {
      "Exercise_Name": "Jumping jack-",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Push-Ups With Feet On An Exercise Ball",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Seated cable shoulder press",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Barbell hack squat",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Feet-elevated push-up",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-20e-feet-elevated-push-up-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-20e-feet-elevated-push-up-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Good Morning",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-09b-barbell-good-morning-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-09b-barbell-good-morning-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Leverage Chest Press",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-65m-machine-chest-press-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-65m-machine-chest-press-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Gironda Sternum Chins",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/292/Male/m/292_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/292/Male/m/292_2.jpg"
    },
    {
      "Exercise_Name": "Exercise ball crunch",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-23s-exercise-ball-crunch-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-23s-exercise-ball-crunch-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Seated rear delt fly",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-47e-seated-rear-delt-fly-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-47e-seated-rear-delt-fly-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Standing face pull",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-40c-standing-face-pull-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-40c-standing-face-pull-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Glute Ham Raise",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-25m-glute-ham-raise-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-25m-glute-ham-raise-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Russian twist",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/2019-xdb-262a-russian-twist-m1-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/2019-xdb-262a-russian-twist-m2-600x600.jpg"
    },
    {
      "Exercise_Name": "Seated Flat Bench Leg Pull-In",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Barbell shrug",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Seated Flat Bench Leg Pull-In",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/93/Male/m/93_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/93/Male/m/93_2.jpg"
    },
    {
      "Exercise_Name": "Barbell shrug",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-04b-barbell-shrug-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-04b-barbell-shrug-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Standing cable rear delt row",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Flat Bench Lying Leg Raise",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-63a-lying-leg-lift-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-63a-lying-leg-lift-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Hack Squat",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Dumbbell skullcrusher",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {"Exercise_Name": "Man-maker", "Exercise_Image": "", "Exercise_Image1": ""},
    {
      "Exercise_Name": "Pallof press",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Knees tucked crunch",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Straight-arm dumbbell pull-over",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-26e-straight-arm-dumbbell-pull-over-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-26e-straight-arm-dumbbell-pull-over-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Arms-crossed jump squat",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-43a-arms-crossed-jump-squat-m2-square-600x600.jpg",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Decline Smith Press",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Band Skull Crusher",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/1211/Male/m/1211_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/1211/Male/m/1211_2.jpg"
    },
    {
      "Exercise_Name": "Side Wrist Pull",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/442/Male/m/442_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/442/Male/m/442_2.jpg"
    },
    {
      "Exercise_Name": "Isometric Wipers",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-122a-typewriter-push-up-m2-square-600x600.jpg",
      "Exercise_Image1": ""
    },
    {"Exercise_Name": "Skating", "Exercise_Image": "", "Exercise_Image1": ""},
    {
      "Exercise_Name": "Cable cross-over",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-1c-cable-cross-over-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-1c-cable-cross-over-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Treadmill running",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "One Arm Pronated Dumbbell Triceps Extension",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Side To Side Chins",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Incline Dumbbell Bench With Palms Facing In",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Seated palms-down wrist curl",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Standing leg swing",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-83s-standing-leg-swing-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-83s-standing-leg-swing-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Clock push-up",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-103a-clock-push-up-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-103a-clock-push-up-m6-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Machine seated row",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-91m-machine-seated-row-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-91m-machine-seated-row-m2-square-600x600.jpg"
    },
    {
      "Exercise_Name": "Lying Face Up Plate Neck Resistance",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/26/Male/m/26_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/26/Male/m/26_2.jpg"
    },
    {
      "Exercise_Name": "Weighted sissy squat",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/2019-xdb-180s-weighted-sissy-squat-m1-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/2019-xdb-180s-weighted-sissy-squat-m2-600x600.jpg"
    },
    {
      "Exercise_Name": "Jog In Place",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Dumbbell Raise",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Palms-Down Dumbbell Wrist Curl Over A Bench",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "One Arm Supinated Dumbbell Triceps Extension",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Jog In Place",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/2963_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/2963_2.jpg"
    },
    {
      "Exercise_Name": "Dumbbell Raise",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/327/Male/m/327_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/327/Male/m/327_2.jpg"
    },
    {
      "Exercise_Name": "Palms-Down Dumbbell Wrist Curl Over A Bench",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/4/Male/m/4_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/4/Male/m/4_2.jpg"
    },
    {
      "Exercise_Name": "One Arm Supinated Dumbbell Triceps Extension",
      "Exercise_Image":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/362/Male/m/362_1.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/exercises/exerciseImages/sequences/362/Male/m/362_2.jpg"
    },
    {
      "Exercise_Name": "Stationary bike",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Dumbbell bent-over row",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Barbell thruster",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Flutter Kicks",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Dumbbell sumo squat",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Barbell upright row",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {"Exercise_Name": "Superman", "Exercise_Image": "", "Exercise_Image1": ""},
    {
      "Exercise_Name": "Straight-Arm Pulldown",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/2019-xdb-104c-straight-arm-bar-pull-down-m1-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/2019-xdb-104c-straight-arm-bar-pull-down-m2-600x600.jpg"
    },
    {
      "Exercise_Name": "Barbell stiff-legged deadlift",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Standing One-Arm Dumbbell Triceps Extension",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Smith machine bench press",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Seated Side Lateral Raise",
      "Exercise_Image": "",
      "Exercise_Image1": ""
    },
    {
      "Exercise_Name": "Dumbbell Lying Rear Lateral Raise",
      "Exercise_Image":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-13n-incline-dumbbell-reverse-fly-m1-square-600x600.jpg",
      "Exercise_Image1":
          "https://www.bodybuilding.com/images/2020/xdb/cropped/xdb-13n-incline-dumbbell-reverse-fly-m2-square-600x600.jpg"
    }
]
  ''';
