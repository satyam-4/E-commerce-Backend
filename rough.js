// try {
//     setTimeout(() => {
//         try {
//             throw new Error("This is an error bhai!!")
//         } catch {
//             console.log("Error catch karliya bhai ne")
//         }
//     }, 1000);
// } catch (error) {
//     console.log("Error catch karliya bhai ne")
// }


// const myPromise = new Promise((resolve, reject) => {
//     setTimeout(() => {
//         reject(new Error("This is error"));
//     }, 10000);

//     setTimeout(() => {
//         resolve("Resolve kardiya");
//     }, 5000);
// })
// .then((res) => {
//     console.log("ye aaya hai:", res)
//     return 5;
// })
// .then((res) => {
//     console.log("ye bhi lete jaao:", res);
// })
// .catch((err) => {
//     console.log("error aaya hai:", err);
// })


// javascript currying

// function sum (a) {
//     return function (b) {
//         return function (c) {
//             return a + b + c
//         }
//     }
// }

// const sum = (a) => (b) => (c) => a + b + c 

// console.log(sum(10)(2)(3))

/*
class Parent {
    pAge = 10;
    
    constructor(pAge = 45) {
        this.pAge = pAge;
    }

    getParentAge() {
        console.log("Parents age:", this.pAge);    
    }
};

class Child extends Parent {
    cAge = 0;
    
    constructor(cAge = 11) {
        // super();
        // this.cAge = cAge;
    }

    getChildAge() {
        console.log("Childs age:", this.cAge); 
    }
}

const c1 = new Child();

c1.getChildAge();
c1.getParentAge();
*/


// const users = {
//     frontendMaster: {},
//     satyam: {}
// }

// let fname = "satyam"

// if(Object.hasOwn(users, fname)) {
//     console.log("Boss")
// } else {
//     console.log("Guest")
// }

// const [a] = [1, 2, 3];
// console.log(a);

// const users = new Map();

// users.set("satyam", {
//     token: 123,
//     expiry: Date.now()
// });

// users.set(1, "satyam");
// users.set("getAge", () => {
//     console.log("Yes bro, the callback is executed!");
// })

// const users2 = {
//     1: "satyam",
//     getAge: () => {
//         console.log("Yes bro, the callback is executed!");
//     }
// }

// users.get("getAge")();  
// users2.getAge();

// console.log(users.get(users.get(1)));
// console.log(NaN === NaN);

